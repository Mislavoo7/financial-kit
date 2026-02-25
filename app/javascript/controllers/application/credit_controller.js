import { Controller } from "@hotwired/stimulus";
import { humanizeEuro, financialRoundUp, parseEuro, percentHumanize, euroToCent } from "./concerns/calculator_helpers";

export default class CreditController extends Controller {
  static targets = ["methodToggle"];

  connect() {
    console.log("credit controller connected");
    this.creditCalculate();
  }

  creditCalculate() {
    const calculatorMethod = this.methodToggleTarget.checked ? "equal-annuities" : "equal-installments";

    const amount = parseFloat(document.querySelector(`[data-amount-in-cent]`).value) || 0;
    const interestRatio = parseFloat(document.querySelector(`[data-interest-ratio]`).value) || 0; // annual %
    const repaymentYear = parseFloat(document.querySelector(`[data-repayment-year]`).value) || 0;
    const monthsOne = parseFloat(document.querySelector(`[data-months-one]`).value) || 1;
    const start = parseFloat(document.querySelector(`[data-start]`).value) || 0;

    const numberOfInstallments = document.querySelector(`[data-number-of-installments]`);
    const timeHorizon = document.querySelector(`[data-time-horizon]`);

    const startAt = document.querySelector(`[data-start-at]`).value;

    const k11 = 12;

    // installments count
    const numberOfInstallmentsValue = repaymentYear * k11;
    numberOfInstallments.value = numberOfInstallmentsValue;

    // horizon (months)
    const k12 = start / 12.0;
    const timeHorizonValue = (repaymentYear + k12) * k11;
    timeHorizon.value = timeHorizonValue;

    // months in table
    const b15 = timeHorizonValue - numberOfInstallmentsValue;
    const numOfRows = timeHorizonValue;

    // Update credit rest placeholders
    document.querySelectorAll(`[data-credit-rest]`).forEach((el) => {
      el.innerHTML = humanizeEuro(amount);
    });

    const tbody = document.querySelector(`[data-credit-months]`);
    const tbodyTotal = document.querySelector(`[data-credit-totals]`);

    // destroy all old trs
    tbody.querySelectorAll("tr:not([data-credit-permanent])").forEach((tr) => tr.remove());
    tbodyTotal.querySelectorAll("tr:not([data-credit-permanent])").forEach((tr) => tr.remove());

    const fragment = document.createDocumentFragment();
    const fragmentTotal = document.createDocumentFragment();

    // periods per year (e.g. monthsOne=1 => 12, monthsOne=3 => 4)
    const b11 = 12.0 / monthsOne;

    let year = this.parseDate(startAt).getFullYear();
    const date = this.parseDate(startAt);

    // periodic interest rate in percent (your sheet uses percent here)
    const c9 = interestRatio / b11;

    let b27 = NaN;
    let d26 = NaN;
    let h26 = NaN;

    let newCreditRestL25 = amount;

    // data for third table
    const totalYearsTable = {};
    let totalObj = { installment: 0, principal: 0, interest: 0, creditRest: 0 };

    for (let rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
      const tr = document.createElement("tr");

      const a26 = rowIndex + 1;

      // =IF(A26>$B$15,A26-$B$15,0)
      const c26 = a26 > b15 ? a26 - b15 : 0;

      // interest for this period (money, round)
      const interestCalc =
        a26 > timeHorizonValue ? 0 : financialRoundUp(newCreditRestL25 * (c9 / 100));

      // principal for this period (money, round)
      const principalRaw = this.calculatePrincipal(
        a26, timeHorizonValue,
        c26, calculatorMethod,
        c9,numberOfInstallmentsValue,
        amount
      );
      const principal = a26 > timeHorizonValue ? 0 : financialRoundUp(principalRaw);

      // installment for this period (money, round)
      const installment = a26 > timeHorizonValue ? 0 : financialRoundUp(principal + interestCalc);

      // remaining balance (money, round)
      newCreditRestL25 =
        a26 > timeHorizonValue ? 0 : financialRoundUp(newCreditRestL25 - principal);

      for (let colIndex = 0; colIndex < 12; colIndex++) {
        const td = document.createElement("td");

        if (colIndex === 0) {
          td.innerHTML = a26;
        } else if (colIndex === 1) {
          let month = this.parseDate(startAt).getMonth() + 1;
          if (rowIndex !== 0) {
            month += rowIndex;
            b27 = month;
          }
          td.innerHTML = month;
        } else if (colIndex === 2) {
          td.innerHTML = c26;
        } else if (colIndex === 3) {
          if (rowIndex === 0) {
            d26 = this.parseDate(startAt).getMonth() + 1;
          } else {
            d26 = this.excelModulo(b27, b11);
          }
          h26 = d26;
          td.innerHTML = d26;
        } else if (colIndex === 4) {
          if (rowIndex !== 0) {
            // new year boundary
            if (d26 === 1) {
              totalYearsTable[`${year}`] = totalObj;
              year += 1;

              totalObj = { installment: 0, principal: 0, interest: 0, creditRest: 0 };
            }
          }

          totalObj.installment = financialRoundUp(totalObj.installment + installment);
          totalObj.principal = financialRoundUp(totalObj.principal + principal);
          totalObj.interest = financialRoundUp(totalObj.interest + interestCalc);

          td.innerHTML = year;
        } else if (colIndex === 6) {
          const nextMonth = this.addMonths(date, rowIndex);
          td.innerHTML = `1.${nextMonth.getMonth() + 1}.${nextMonth.getFullYear()}.`;
        } else if (colIndex === 7) {
          td.innerHTML = h26;
        } else if (colIndex === 8) {
          td.innerHTML = humanizeEuro(installment);
        } else if (colIndex === 9) {
          td.innerHTML = humanizeEuro(principal);
        } else if (colIndex === 10) {
          td.innerHTML = humanizeEuro(interestCalc);
        } else if (colIndex === 11) {
          td.innerHTML = humanizeEuro(newCreditRestL25);
        }

        td.dataset.row = rowIndex + 26;
        td.dataset.col = String.fromCharCode(97 + colIndex);

        tr.appendChild(td);
      }

      fragment.appendChild(tr);

      // keep latest totals for current year
      totalYearsTable[`${year}`] = totalObj;
    }

    tbody.appendChild(fragment);

    // third table
    let lastCreditRest = amount;

    const sumValues = { installment: 0, principal: 0, interest: 0, creditRest: 0 };

    for (const row in totalYearsTable) {
      const tr = document.createElement("tr");

      for (let colIndex = 0; colIndex < 5; colIndex++) {
        const td = document.createElement("td");

        if (colIndex === 0) {
          td.innerHTML = row;
        } else if (colIndex === 1) {
          td.innerHTML = humanizeEuro(totalYearsTable[row].installment);
          sumValues.installment = financialRoundUp(sumValues.installment + totalYearsTable[row].installment);
        } else if (colIndex === 2) {
          td.innerHTML = humanizeEuro(totalYearsTable[row].principal);
          sumValues.principal = financialRoundUp(sumValues.principal + totalYearsTable[row].principal);
        } else if (colIndex === 3) {
          td.innerHTML = humanizeEuro(totalYearsTable[row].interest);
          sumValues.interest = financialRoundUp(sumValues.interest + totalYearsTable[row].interest);
        } else if (colIndex === 4) {
          lastCreditRest = financialRoundUp(lastCreditRest - totalYearsTable[row].principal);
          td.innerHTML = humanizeEuro(lastCreditRest);
          sumValues.creditRest = financialRoundUp(sumValues.creditRest + lastCreditRest);
        }

        tr.appendChild(td);
      }

      fragmentTotal.appendChild(tr);
    }

    const trTotal = document.createElement("tr");
    trTotal.className = "credit-total-row";

    for (let colIndex = 0; colIndex < 5; colIndex++) {
      const td = document.createElement("td");

      if (colIndex === 0) td.innerHTML = "";
      else if (colIndex === 1) td.innerHTML = humanizeEuro(sumValues.installment);
      else if (colIndex === 2) td.innerHTML = humanizeEuro(sumValues.principal);
      else if (colIndex === 3) td.innerHTML = humanizeEuro(sumValues.interest);
      else if (colIndex === 4) td.innerHTML = "-";

      trTotal.appendChild(td);
    }

    fragmentTotal.appendChild(trTotal);
    tbodyTotal.appendChild(fragmentTotal);
  }

  // helpers
  parseDate(dateString) {
    const parts = dateString.split('.');
    if (parts.length === 3) {
      const day = parseInt(parts[0], 10);
      const month = parseInt(parts[1], 10) - 1; // JS months are 0-indexed
      const year = parseInt(parts[2], 10);
      return new Date(year, month, day);
    } else {
      return new Date(dateString);
    }
  }

  addMonths(baseDate, monthsToAdd) {
    const d = new Date(baseDate); 
    const day = d.getDate();

    d.setMonth(d.getMonth() + monthsToAdd);

    if (d.getDate() < day) {
      d.setDate(0); // go to last day of previous month
    }

    return d;
  }

  excelModulo(value, divisor) {
    const mod = value % divisor;
    return mod === 0 ? divisor : mod;
  }

  PMT(rate, nper, pv) {
    if (rate === 0) return -(pv / nper);
    return -(pv * rate) / (1 - Math.pow(1 + rate, -nper));
  }

  PPMT(rate, per, nper, pv) {
    const pmt = this.PMT(rate, nper, pv);
    const ipmt = this.IPMT(rate, per, nper, pv);
    return pmt - ipmt;
  }

  IPMT(rate, per, nper, pv) {
    if (per === 1) {
      return -pv * rate;
    }

    const pmt = this.PMT(rate, nper, pv);
    const balance =
      pv * Math.pow(1 + rate, per - 1) +
      pmt * (Math.pow(1 + rate, per - 1) - 1) / rate;

    return -balance * rate;
  }

  FV(rate, nper, pmt, pv, type = 0) {
    if (rate === 0) {
      return -(pv + pmt * nper);
    }

    const pvif = Math.pow(1 + rate, nper);
    let fv = -(pv * pvif + pmt * (1 + rate * type) * ((pvif - 1) / rate));

    return fv;
  }


  calculatePrincipal(a26, timeHorizonValue, c26, calculatorMethod, c9, numberOfInstallmentsValue, amount) {
    let value;

    if (a26 > timeHorizonValue) {
      value = 0;
    } else if (c26 === 0) {
      value = 0;
    } else if (calculatorMethod === "equal-annuities") {
      const rateDecimal = c9 / 100;
      value = this.PPMT(rateDecimal, c26, numberOfInstallmentsValue, amount) * -1;
    } else {
      value = amount / numberOfInstallmentsValue;
    }

    return value;
  }
}
