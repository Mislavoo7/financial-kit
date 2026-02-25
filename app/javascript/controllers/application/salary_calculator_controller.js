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

    // deductions for dependents
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
    var amountInCent = parseFloat(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0");
    var amountInEuro = amountInCent / 100.00;
    var kidsNum = parseInt(this.element.querySelector(`[data-kids-num-input]`)?.value || "0", 10);
    var dependentsNum = parseInt(this.element.querySelector(`[data-dependents-num-input]`)?.value || "0", 10);
    var disabilityEl = this.element.querySelector(`[data-disability-input]:checked`);
    var disability = disabilityEl ? disabilityEl.value : null;

    var cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    var cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;

    if (cityTaxRate) {
      var pdvOne = cityTaxRate ? Number(cityTaxRate.lower_rate) : null;
      var pdvTwo = cityTaxRate ? Number(cityTaxRate.higher_rate) : null;
    }
    var calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";
    var minSalary = 600.00;
    var breakingPoint = 5000;
    var healthInsuranceInPercent = 0.165;

    // calculate deduction
    var personalDeduction = this.getPersonalDeduction(kidsNum, dependentsNum, disability); 
    var personalDeductionInEuro = 0;

    // calculate pillars
    var firstPillar = 0.15;
    var secondPillar = 0.05;
    var firstPillarInEuro = 0;
    var totalPillar = firstPillar + secondPillar;
    var totalPillarInEuro = 0;
    var secondPillarInEuro = amountInEuro * secondPillar;

    if (amountInEuro <= 700) {
      // up to 700 eur sub 300 eur and multiple by 15%
      firstPillarInEuro = (amountInEuro - 300) * firstPillar;
      totalPillarInEuro = firstPillarInEuro + secondPillarInEuro;
      personalDeductionInEuro = amountInEuro - totalPillarInEuro;
    } else if (amountInEuro > 700 && amountInEuro <= 1300) {
      // from 700 to 1300 calculate with 0.5*(1300-brut). Brut subs and multiply 15%
      firstPillarInEuro = (amountInEuro - (0.5 * (1300 - amountInEuro))) * firstPillar;
      totalPillarInEuro = firstPillarInEuro + secondPillarInEuro;
      if (amountInEuro <= 1022) {  // No clue why 1022 - came up with that number empirically
        personalDeductionInEuro = amountInEuro - totalPillarInEuro
      } else {
        personalDeductionInEuro = minSalary * personalDeduction;
      }
    } else {
      firstPillarInEuro = amountInEuro * firstPillar;
      totalPillarInEuro = firstPillarInEuro + secondPillarInEuro;
      personalDeductionInEuro = minSalary * personalDeduction;
    }

    // calculate other
    if ( amountInEuro - totalPillarInEuro <= personalDeductionInEuro ) {
      var taxationBase = 0;
      var personalDeductionInEuro = amountInEuro - totalPillarInEuro;
    } else {
      var taxationBase = amountInEuro - totalPillarInEuro - personalDeductionInEuro;
    }

    if (taxationBase < breakingPoint) {
      var lowTax = financialRoundUp(taxationBase * pdvOne); 
      var highTax = 0;
      var incomeTax = lowTax;
    } else {
      var lowTax = breakingPoint * pdvOne;
      var highTax = (taxationBase - breakingPoint) * pdvTwo;
      var incomeTax = financialRoundUp(lowTax + highTax); 
    }

    var healthInsurance = amountInEuro * healthInsuranceInPercent;
    var employerToPay = financialRoundUp(amountInEuro + healthInsurance);
    var netSalary = financialRoundUp(taxationBase - incomeTax + personalDeductionInEuro);

    // add to DOM
    console.log("d")
    this.element.querySelector(`[data-brut]`).innerHTML = amountInEuro;
    this.element.querySelector(`[data-brut-hidden]`).value = amountInCent;

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
    this.element.querySelector(`[data-personal-deduction]`).value = humanizeEuro(personalDeductionInEuro);

    this.element.querySelector(`[data-taxation-base-hidden]`).value = euroToCent(taxationBase);
    this.element.querySelector(`[data-taxation-base]`).value = humanizeEuro(taxationBase);

    this.element.querySelector(`[data-taxation-base-hidden]`).value = euroToCent(taxationBase);
    this.element.querySelector(`[data-taxation-base]`).value = humanizeEuro(taxationBase);

    this.element.querySelector(`[data-pdv-one-ratio]`).innerHTML = percentHumanize(pdvOne);
    this.element.querySelector(`[data-pdv-one-ratio-hidden]`).value = pdvOne;
    this.element.querySelector(`[data-pdv-one]`).innerHTML = humanizeEuro(lowTax);
    this.element.querySelector(`[data-pdv-one-hidden]`).value = euroToCent(lowTax);
    this.element.querySelector(`[data-pdv-two-ratio]`).innerHTML = percentHumanize(pdvTwo);
    this.element.querySelector(`[data-pdv-two-ratio-hidden]`).value = pdvTwo;
    this.element.querySelector(`[data-pdv-two]`).innerHTML = humanizeEuro(highTax);
    this.element.querySelector(`[data-pdv-two-hidden]`).value = euroToCent(highTax);

    this.element.querySelector(`[data-income-tax-hidden]`).value = euroToCent(incomeTax);
    this.element.querySelector(`[data-income-tax]`).value = humanizeEuro(incomeTax);

    this.element.querySelector(`[data-health-insurance-ratio]`).innerHTML = percentHumanize(healthInsuranceInPercent);
    this.element.querySelector(`[data-health-insurance-ratio-hidden]`).value = healthInsuranceInPercent;
    this.element.querySelector(`[data-health-insurance]`).innerHTML = humanizeEuro(healthInsurance);
    this.element.querySelector(`[data-health-insurance-hidden]`).value = euroToCent(healthInsurance);

    this.element.querySelector(`[data-employer-to-pay-hidden]`).value = euroToCent(employerToPay);
    this.element.querySelector(`[data-employer-to-pay]`).value = humanizeEuro(employerToPay);

    this.element.querySelector(`[data-net-hidden]`).value = euroToCent(netSalary);
    this.element.querySelector(`[data-net]`).value = humanizeEuro(netSalary);
  }
}
