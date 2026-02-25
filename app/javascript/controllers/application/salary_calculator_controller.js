import { Controller } from "@hotwired/stimulus";
import autoComplete from "@tarekraafat/autocomplete.js";
import { humanizeEuro, financialRoundUp, parseEuro, percentHumanize, euroToCent } from "./concerns/calculator_helpers";

export default class extends Controller {
  static targets = ["methodToggle", "citySearch", "cityTaxRateId"];
  static values = {
    cityTaxRates: Array, // [{id, title, lower_rate, higher_rate}, ...]
  };

  connect() {
    this.cityTaxRateById = new Map(this.cityTaxRatesValue.map((r) => [Number(r.id), r]));
    this.cityTaxRateByTitle = new Map(
      this.cityTaxRatesValue.map((r) => [String(r.title).toLowerCase(), r])
    );

    this.initCityAutocomplete();
    this.salaryCalculate();
  }

  initCityAutocomplete() {
    if (!this.hasCitySearchTarget) return;

    new autoComplete({
      selector: () => this.citySearchTarget,
      threshold: 1,

      data: {
        src: this.cityTaxRatesValue,
      },

      searchEngine: (query, record) => {
        return record.title?.toLowerCase().includes(query.toLowerCase());
      },

      resultsList: {
        maxResults: 20,
        noResults: true,
      },

      resultItem: {
        element: (item, data) => {
          item.innerHTML = data.value.title;
        },
      },

      events: {
        input: {
          selection: (event) => {
            const selected = event.detail.selection.value; // object
            this.citySearchTarget.value = selected.title;
            this.cityTaxRateIdTarget.value = selected.id;
            this.salaryCalculate(); // run the salary calc
          },
        },
      },
    });
  }

  getPersonalDeduction(kidsNum, dependentsNum, disability) {
    // settings
    var total = 1;
    var kidFacilitations = [0.5, 0.7, 1, 1.4, 1.9, 2.5, 3.2, 4, 4.9, 6];
    var kidAfterTentht = 1.1; 
    var dependentsFacilitation = 0.5;
    var lessThenTotalDis = 0.3;
    var totalDis = 1;

    // deductions for kids
    if (!(kidsNum <= 0)) { 
      if (kidsNum > 0 && kidsNum <= kidFacilitations.length) {
        for (var i=0; i < kidsNum; i++ ) {
          total += kidFacilitations[i];
        }
      } else {
        var kidFacilitationsSum = kidFacilitations.reduce(function(accumulator, currentValue) {
          return accumulator + currentValue;
        }, 0);
        var additionalKids = kidsNum - kidFacilitations.length
        for (var i=0; i < additionalKids; i++ ) {
          kidFacilitationsSum += kidAfterTentht
        }

        total += kidFacilitationsSum + (additionalKids * kidAfterTentht);
      }
    }

    // deductions for dependent people
    total += dependentsNum * dependentsFacilitation;

    // deductions for disability 
    if (disability == "partial-disability") {
      total += lessThenTotalDis;
    } else if (disability == "total-disability") {
      total += totalDis;
    }
    return total
  }

  salaryCalculate() {
    // settings
    const calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";

    const amountInEuro = parseFloat(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0") || 0;

    const kidsNum = parseInt(this.element.querySelector(`[data-kids-num-input]`)?.value || "0", 10) || 0;

    const dependentsNum = parseInt(this.element.querySelector(`[data-dependents-num-input]`)?.value || "0", 10) || 0;

    const disabilityEl = this.element.querySelector(`[data-disability-input]:checked`);
    const disability = disabilityEl ? disabilityEl.value : null;

    const cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    const cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;

    // tax rates (as decimals, e.g. 0.18)
    const pdvOne = cityTaxRate ? Number(cityTaxRate.lower_rate) : 0;
    const pdvTwo = cityTaxRate ? Number(cityTaxRate.higher_rate) : 0;

    const minSalary = 600.0;
    const breakingPoint = 5000;
    const healthInsuranceInPercent = 0.165;

    // deduction coefficient (not money yet)
    const personalDeductionCoeff = this.getPersonalDeduction(kidsNum, dependentsNum, disability);

    // pillars rates
    const firstPillar = 0.15;
    const secondPillar = 0.05;
    const totalPillar = firstPillar + secondPillar; // don't round a rate

    let firstPillarInEuro = 0;

    // calculations
    if (amountInEuro <= 700) {
      // up to 700: (brut - 300) * 15%
      firstPillarInEuro = financialRoundUp((amountInEuro - 300) * firstPillar);
    } else if (amountInEuro <= 1300) {
      // 700..1300: (brut - 0.5*(1300 - brut)) * 15%
      firstPillarInEuro = financialRoundUp(
        (amountInEuro - (0.5 * (1300 - amountInEuro))) * firstPillar
      );
    } else {
      firstPillarInEuro = financialRoundUp(amountInEuro * firstPillar);
    }

    const secondPillarInEuro = financialRoundUp(amountInEuro * secondPillar);
    const totalPillarInEuro = financialRoundUp(firstPillarInEuro + secondPillarInEuro);

    // base after pillars (money)
    const baseAfterPillars = financialRoundUp(amountInEuro - totalPillarInEuro);

    // desired deduction from coefficient
    const desiredPersonalDeductionInEuro = minSalary * personalDeductionCoeff; // keep raw
    // clamp so it never exceeds baseAfterPillars
    const personalDeductionInEuro = financialRoundUp(
      Math.min(desiredPersonalDeductionInEuro, baseAfterPillars)
    );

    const taxationBase = financialRoundUp(Math.max(0, baseAfterPillars - personalDeductionInEuro));

    let lowTax = 0;
    let highTax = 0;
    let incomeTax = 0;

    if (taxationBase < breakingPoint) {
      lowTax = financialRoundUp(taxationBase * pdvOne);
      highTax = 0;
      incomeTax = lowTax;
    } else {
      lowTax = financialRoundUp(breakingPoint * pdvOne);
      highTax = financialRoundUp((taxationBase - breakingPoint) * pdvTwo);
      incomeTax = financialRoundUp(lowTax + highTax);
    }

    const healthInsurance = financialRoundUp(amountInEuro * healthInsuranceInPercent);
    const employerToPay = financialRoundUp(amountInEuro + healthInsurance);
    const netSalary = financialRoundUp(taxationBase - incomeTax + personalDeductionInEuro);

    // add to DOM
    this.element.querySelector(`[data-brut]`).innerHTML = humanizeEuro(amountInEuro);
    this.element.querySelector(`[data-brut-hidden]`).value = euroToCent(amountInEuro);

    this.element.querySelector(`[data-first-pillar-ratio]`).innerHTML = percentHumanize(firstPillar);
    this.element.querySelector(`[data-first-pillar-ratio-hidden]`).value = firstPillar;
    this.element.querySelector(`[data-first-pillar]`).innerHTML = humanizeEuro(firstPillarInEuro);
    this.element.querySelector(`[data-first-pillar-hidden]`).value = euroToCent(firstPillarInEuro);

    this.element.querySelector(`[data-second-pillar-ratio]`).innerHTML = percentHumanize(secondPillar);
    this.element.querySelector(`[data-second-pillar-ratio-hidden]`).value = secondPillar;
    this.element.querySelector(`[data-second-pillar]`).innerHTML = humanizeEuro(secondPillarInEuro);
    this.element.querySelector(`[data-second-pillar-hidden]`).value = euroToCent(secondPillarInEuro);

    this.element.querySelector(`[data-total-pillar-ratio]`).innerHTML = percentHumanize(totalPillar);
    this.element.querySelector(`[data-total-pillar-ratio-hidden]`).value = totalPillar;
    this.element.querySelector(`[data-total-pillar]`).innerHTML = humanizeEuro(totalPillarInEuro);
    this.element.querySelector(`[data-total-pillar-hidden]`).value = euroToCent(totalPillarInEuro);

    this.element.querySelector(`[data-personal-deduction-hidden]`).value = euroToCent(personalDeductionInEuro);
    this.element.querySelector(`[data-personal-deduction]`).innerHTML = humanizeEuro(personalDeductionInEuro);

    this.element.querySelector(`[data-taxation-base-hidden]`).value = euroToCent(taxationBase);
    this.element.querySelector(`[data-taxation-base]`).innerHTML = humanizeEuro(taxationBase);

    this.element.querySelector(`[data-pdv-one-ratio]`).innerHTML = percentHumanize(pdvOne);
    this.element.querySelector(`[data-pdv-one-ratio-hidden]`).value = pdvOne;
    this.element.querySelector(`[data-pdv-one]`).innerHTML = humanizeEuro(lowTax);
    this.element.querySelector(`[data-pdv-one-hidden]`).value = euroToCent(lowTax);

    this.element.querySelector(`[data-pdv-two-ratio]`).innerHTML = percentHumanize(pdvTwo);
    this.element.querySelector(`[data-pdv-two-ratio-hidden]`).value = pdvTwo;
    this.element.querySelector(`[data-pdv-two]`).innerHTML = humanizeEuro(highTax);
    this.element.querySelector(`[data-pdv-two-hidden]`).value = euroToCent(highTax);

    this.element.querySelector(`[data-income-tax-hidden]`).value = euroToCent(incomeTax);
    this.element.querySelector(`[data-income-tax]`).innerHTML = humanizeEuro(incomeTax);

    this.element.querySelector(`[data-health-insurance-ratio]`).innerHTML = percentHumanize(healthInsuranceInPercent);
    this.element.querySelector(`[data-health-insurance-ratio-hidden]`).value = healthInsuranceInPercent;
    this.element.querySelector(`[data-health-insurance]`).innerHTML = humanizeEuro(healthInsurance);
    this.element.querySelector(`[data-health-insurance-hidden]`).value = euroToCent(healthInsurance);

    this.element.querySelector(`[data-employer-to-pay-hidden]`).value = euroToCent(employerToPay);
    this.element.querySelector(`[data-employer-to-pay]`).innerHTML = humanizeEuro(employerToPay);

    this.element.querySelector(`[data-net-hidden]`).value = euroToCent(netSalary);
    this.element.querySelector(`[data-net]`).innerHTML = humanizeEuro(netSalary);
  }
}
