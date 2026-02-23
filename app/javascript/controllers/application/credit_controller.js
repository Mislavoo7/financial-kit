import { Controller } from "@hotwired/stimulus";

export default class CreditController extends Controller {
  static targets = [ "methodToggle" ]

  connect() {
    console.log("credit controller connected");
    this.creditCalculate()
  }

  creditCalculate() {
    // main table
    var calculatorMethod = this.methodToggleTarget.checked ? "equal-annuities" : "equal-installments";
    var amount = parseFloat(document.querySelector(`[data-amount-in-cent]`).value);
    var interestRatio = parseFloat(document.querySelector(`[data-interest-ratio]`).value);
    var repaymentYear = parseFloat(document.querySelector(`[data-repayment-year]`).value); 
    var monthsOne = parseFloat(document.querySelector(`[data-months-one]`).value);
    var start = parseFloat(document.querySelector(`[data-start]`).value);

    var numberOfInstallments = document.querySelector(`[data-number-of-installments]`);
    var timeHorizon = document.querySelector(`[data-time-horizon]`);

    var startAt = document.querySelector(`[data-start-at]`).value;

    var k11 = 12 


    // =(J10)*K11
    var numberOfInstallmentsValue = repaymentYear * k11;
    numberOfInstallments.value = numberOfInstallmentsValue;

    // =(J10+K12)*K11
    var k12 = start/12.0;
    var timeHorizonValue = (repaymentYear + k12 ) * k11;
    timeHorizon.value = timeHorizonValue;

    // months in table
    var b15 = timeHorizonValue - numberOfInstallmentsValue;
    var numOfRows = timeHorizonValue;

    var creditRest = document.querySelectorAll(`[data-credit-rest]`);
    for (var i=0; i < creditRest.length; i++) {
      creditRest[i].innerHTML = this.humanizeEuro(amount);
    }

    var tbody = document.querySelector(`[data-credit-months]`);
    var tbodyTotal = document.querySelector(`[data-credit-totals]`);

    // destroy all trs
    tbody.querySelectorAll('tr:not([data-credit-permanent])').forEach(tr => tr.remove());
    tbodyTotal.querySelectorAll('tr:not([data-credit-permanent])').forEach(tr => tr.remove());

    var fragment = document.createDocumentFragment();
    var fragmentTotal = document.createDocumentFragment();

    var a26 = NaN;
    var b27 = NaN;
    var b11 = 12.0 / monthsOne;
    var d26 = NaN;
    var year = this.parseDate(startAt).getFullYear();
    var date = this.parseDate(startAt)
    var h26 = NaN;
    var l25 = amount; 
    var c9 = interestRatio / b11; 
    var c26 = NaN;
    var j26 = NaN;
    var i26 = NaN;
    var newCreditRestL25 = amount;

    var interesetCalculation = NaN;

    // data for third table {2019: {instalments: 55566, principal: 66666...}}
    var totalYearsTable = {}
    var totalObj = {
      installment: 0,
      principal: 0,
      interest: 0,
      creditRest: 0
    }

    for (var rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
      var tr = document.createElement("tr");

      a26 = rowIndex + 1

      // =IF(A26>$B$15,A26-$B$15,0)
      c26 = a26 > b15 ? a26 - b15 : 0;

      // =IF(A26>$J$15," ",L25*$C$9)
      //var interesetCalculation = a26 > timeHorizonValue ? 0 : (l25 * c9)/100.00;
      var interesetCalculation = (a26 > timeHorizonValue) ? 0 : newCreditRestL25 * (c9 / 100);

      // =IF(A26>$J$15," ",IF(C26=0,0,IF($C$5=2,PPMT($C$9,C26,$J$14,$J$8,0)*(-1),$C$8)))
      j26 = this.calculatePrincipal(a26, timeHorizonValue, c26, calculatorMethod, c9, numberOfInstallmentsValue, amount);

      var principal = j26;

      // =IF(A26>$J$15," ",J26+K26)
      i26 = (a26 > timeHorizonValue) ? 0 : (j26 + interesetCalculation).toFixed(2)

      // =IF(A26>$J$15," ",L25-J26)
      newCreditRestL25 = (a26 > timeHorizonValue)  ? 0 : newCreditRestL25 - principal;

      for (var colIndex = 0; colIndex < 12; colIndex++) {
        var td = document.createElement("td");

        if (colIndex == 0) {
          td.innerHTML = a26
        } else if (colIndex == 1) {
          var month = this.parseDate(startAt).getMonth() + 1;
          if (rowIndex != 0) {
            month += rowIndex;
            b27 = month;
          }

          td.innerHTML = month 
        } else if (colIndex == 2) {
          // =IF(A26>$B$15,A26-$B$15,0)
          td.innerHTML = c26 
        } else if (colIndex == 3) {
          if (rowIndex == 0) {
            d26 = this.parseDate(startAt).getMonth() + 1;
          } else {
            // =IF(MOD(B27,$B$11)=0,$B$11,MOD(B27,$B$11))
            d26 = this.excelModulo(b27, b11); 
          } 
          h26 = d26;
          td.innerHTML = d26;
        } else if (colIndex == 4) {
          if (rowIndex != 0) {
            // =IF(D27=1,E26+1,E26)
            if (d26===1) {
              totalYearsTable[`${year}`] = totalObj
              year += 1;

              // add data to the third (total table) and reset totalObject
              totalObj = {
                installment: 0,
                principal: 0,
                interest: 0,
                creditRest: 0
              }
            }
          }

          totalObj.installment += parseFloat(i26)
          totalObj.principal += j26
          totalObj.interest += interesetCalculation

          td.innerHTML = year 
        } else if (colIndex == 6) {
          var nextMonth = this.addMonths(date, rowIndex)
          td.innerHTML = `1.${nextMonth.getMonth() + 1}.${nextMonth.getFullYear()}.` 
        } else if (colIndex == 7) {
          td.innerHTML = h26; 
        } else if (colIndex == 8) {
          td.innerHTML = typeof value === "number" ? this.humanizeEuro(i26.toFixed(2)) : this.humanizeEuro(i26);
        } else if (colIndex == 9) {
          td.innerHTML = typeof value === "number" ? this.humanizeEuro(j26.toFixed(2)) : this.humanizeEuro(j26.toFixed(2));
        } else if (colIndex == 10) {
          td.innerHTML = this.humanizeEuro(interesetCalculation.toFixed(2)); 
        } else if (colIndex == 11) {
          td.innerHTML = this.humanizeEuro(newCreditRestL25.toFixed(2)); 
        }

        td.dataset.row = rowIndex+26; // bc excel sheet starts on the row 26
        td.dataset.col = String.fromCharCode(97 + colIndex); // 1,2,3,4... to a,b,c,d...

        // special attribute for last column if needed
        // td.setAttribute("data-credit-rest", "");

        tr.appendChild(td);
      }

      fragment.appendChild(tr);

      // totalObject is ususally added on the first month. The remaining amounts should be added here, at the end
      totalYearsTable[`${year}`] = totalObj
    }

    tbody.appendChild(fragment);

    // Third table total
    var lastCreditRest = amount;

    var sumValues = {
      installment: 0,
      principal: 0,
      interest: 0,
      creditRest: 0
    }

    var yearIndex = 1
    for (var row in totalYearsTable) {
      let tr = document.createElement("tr");

      for (var colIndex = 0; colIndex < 5; colIndex++) {
        var td = document.createElement("td");

        if (colIndex == 0) {
          td.innerHTML = row
        } else if (colIndex == 1) {
          td.innerHTML = this.humanizeEuro(totalYearsTable[row].installment.toFixed(2))
          sumValues.installment += totalYearsTable[row].installment 
        } else if (colIndex == 2) {
          td.innerHTML = this.humanizeEuro(totalYearsTable[row].principal.toFixed(2))
          sumValues.principal += totalYearsTable[row].principal 
        } else if (colIndex == 3) {
          td.innerHTML = this.humanizeEuro(`${totalYearsTable[row].interest.toFixed(2)}`)
          sumValues.interest += totalYearsTable[row].interest 
        } else if (colIndex == 4) {
          lastCreditRest = lastCreditRest - totalYearsTable[row].principal
          td.innerHTML = this.humanizeEuro(lastCreditRest.toFixed(2))
          sumValues.creditRest += lastCreditRest 
        }
        tr.appendChild(td);
      }

      fragmentTotal.appendChild(tr);
    }

    let trTotal = document.createElement("tr");
    trTotal.className = "credit-total-row";
    for (var colIndex = 0; colIndex < 5; colIndex++) {
      var td = document.createElement("td");

      if (colIndex == 0) {
        td.innerHTML = ""
      } else if (colIndex == 1) {
        td.innerHTML = this.humanizeEuro(sumValues.installment.toFixed(2))
      } else if (colIndex == 2) {
        td.innerHTML = this.humanizeEuro(sumValues.principal.toFixed(2))
      } else if (colIndex == 3) {
        td.innerHTML = this.humanizeEuro(sumValues.interest.toFixed(2))
      } else if (colIndex == 4) {
        td.innerHTML = "-" //sumValues.creditRest.toFixed(2)
      }
      trTotal.appendChild(td);
    }
    fragmentTotal.appendChild(trTotal);

    tbodyTotal.appendChild(fragmentTotal);
  } 

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
    const d = new Date(baseDate); // clone
    const day = d.getDate();

    d.setMonth(d.getMonth() + monthsToAdd);

    // Handle month overflow (e.g. Jan 31 → Feb)
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
    var value;
    if (a26 > timeHorizonValue) {
      value = " ";
    } else if (c26 === 0) {
      value = 0;
    } else if (calculatorMethod === "equal-annuities") {
      var rateDecimal = c9/100;
      value = this.PPMT(rateDecimal, c26, numberOfInstallmentsValue, amount) * -1;
    } else {
      var c8 = amount / numberOfInstallmentsValue;
      value = c8;
    }
    return value 
  }

  // TODO seperate
  humanizeEuro(euro) {
    // accepts: 5000, "5000", "5000.2", "5.000,20", "€5,000.20"
    const parseEuro = (v) => {
      if (v == null) return 0;
      let s = String(v).trim();

      // keep digits, comma, dot, minus
      s = s.replace(/[^\d.,-]/g, "");

      // If both '.' and ',' exist: decide which is decimal by last occurrence
      const lastDot = s.lastIndexOf(".");
      const lastComma = s.lastIndexOf(",");
      if (lastDot !== -1 && lastComma !== -1) {
        const decimalIsComma = lastComma > lastDot;
        if (decimalIsComma) {
          // "1.234,56" -> remove thousands dots, turn comma into dot
          s = s.replace(/\./g, "").replace(",", ".");
        } else {
          // "1,234.56" -> remove thousands commas
          s = s.replace(/,/g, "");
        }
      } else if (lastComma !== -1) {
        // only comma: treat as decimal separator
        s = s.replace(",", ".");
      }
      const n = Number(s);
      return Number.isFinite(n) ? n : 0;
    };

    const n = parseEuro(euro);

    return new Intl.NumberFormat("hr-HR", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    }).format(n);
  }
}
