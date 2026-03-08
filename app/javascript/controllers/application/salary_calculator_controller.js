import { Controller } from "@hotwired/stimulus";
import { initCityAutocomplete } from "./concerns/autocomplete";
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

    // settings FIRST (before any calculation)
    this.minSalary = 600.0;
    this.breakingPoint = 5000;
    this.healthInsuranceInPercent = 0.165;

    this.firstPillar = 0.15;
    this.secondPillar = 0.05;
    this.totalPillar = this.firstPillar + this.secondPillar;

    initCityAutocomplete({
      input: this.citySearchTarget,
      hiddenInput: this.cityTaxRateIdTarget,
      data: this.cityTaxRatesValue,
      onSelect: () => this.salaryCalculate()
    });
    this.salaryCalculate();
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

  incomeToGross(income, netSalary) {
    var limits = 1872.00; 
    if (income <= 285) {
      return income / 0.95;
    } else if (income > 285 && income <= 605) {
      return (income -45) / 0.80;
    } else if (income > 605 && income <= 1040) {
      return (income - 97.5) / 0.725;
    } else if (income > 1040) {
      return income / 0.8;
    }
  };

  brutToNet(amountInEuro) {
    let firstPillarInEuro = 0;

    // calculations
    if (amountInEuro <= 700) {
      // up to 700: (brut - 300) * 15%
      firstPillarInEuro = financialRoundUp((amountInEuro - 300) * this.firstPillar);
    } else if (amountInEuro <= 1300) {
      // 700..1300: (brut - 0.5*(1300 - brut)) * 15%
      firstPillarInEuro = financialRoundUp(
        (amountInEuro - (0.5 * (1300 - amountInEuro))) * this.firstPillar
      );
    } else {
      firstPillarInEuro = financialRoundUp(amountInEuro * this.firstPillar);
    }

    const secondPillarInEuro = financialRoundUp(amountInEuro * this.secondPillar);
    this.totalPillarInEuro = financialRoundUp(firstPillarInEuro + secondPillarInEuro);

    this.baseAfterPillars = financialRoundUp(amountInEuro - this.totalPillarInEuro);
    const desiredPersonalDeductionInEuro = this.minSalary * this.personalDeductionCoeff; // keep raw
    this.personalDeductionInEuro = financialRoundUp(
      Math.min(desiredPersonalDeductionInEuro, this.baseAfterPillars)
    );

    const taxationBase = financialRoundUp(Math.max(0, this.baseAfterPillars - this.personalDeductionInEuro));

    let lowTax = 0;
    let highTax = 0;
    let incomeTax = 0;

    if (taxationBase < this.breakingPoint) {
      lowTax = financialRoundUp(taxationBase * this.pdvOne);
      highTax = 0;
      incomeTax = lowTax;
    } else {
      lowTax = financialRoundUp(this.breakingPoint * this.pdvOne);
      highTax = financialRoundUp((taxationBase - this.breakingPoint) * this.pdvTwo);
      incomeTax = financialRoundUp(lowTax + highTax);
    }

    const healthInsurance = financialRoundUp(amountInEuro * this.healthInsuranceInPercent);
    const employerToPay = financialRoundUp(amountInEuro + healthInsurance);
    const netSalary = financialRoundUp(taxationBase - incomeTax + this.personalDeductionInEuro);

    // add to DOM
    this.element.querySelector(`[data-brut]`).innerHTML = humanizeEuro(amountInEuro);
    this.element.querySelector(`[data-brut-hidden]`).value = euroToCent(amountInEuro);

    this.element.querySelector(`[data-first-pillar-ratio]`).innerHTML = percentHumanize(this.firstPillar);
    this.element.querySelector(`[data-first-pillar-ratio-hidden]`).value = this.firstPillar;
    this.element.querySelector(`[data-first-pillar]`).innerHTML = humanizeEuro(firstPillarInEuro);
    this.element.querySelector(`[data-first-pillar-hidden]`).value = euroToCent(firstPillarInEuro);

    this.element.querySelector(`[data-second-pillar-ratio]`).innerHTML = percentHumanize(this.secondPillar);
    this.element.querySelector(`[data-second-pillar-ratio-hidden]`).value = this.secondPillar;
    this.element.querySelector(`[data-second-pillar]`).innerHTML = humanizeEuro(secondPillarInEuro);
    this.element.querySelector(`[data-second-pillar-hidden]`).value = euroToCent(secondPillarInEuro);

    this.element.querySelector(`[data-total-pillar-ratio]`).innerHTML = percentHumanize(this.totalPillar);
    this.element.querySelector(`[data-total-pillar-ratio-hidden]`).value = this.totalPillar;
    this.element.querySelector(`[data-total-pillar]`).innerHTML = humanizeEuro(this.totalPillarInEuro);
    this.element.querySelector(`[data-total-pillar-hidden]`).value = euroToCent(this.totalPillarInEuro);

    this.element.querySelector(`[data-personal-deduction-hidden]`).value = this.personalDeductionCoeff;
    this.element.querySelector(`[data-personal-deduction]`).innerHTML = humanizeEuro(this.personalDeductionInEuro);

    this.element.querySelector(`[data-taxation-base-hidden]`).value = euroToCent(taxationBase);
    this.element.querySelector(`[data-taxation-base]`).innerHTML = humanizeEuro(taxationBase);

    this.element.querySelector(`[data-pdv-one-ratio]`).innerHTML = percentHumanize(this.pdvOne);
    this.element.querySelector(`[data-pdv-one-ratio-hidden]`).value = this.pdvOne;
    this.element.querySelector(`[data-pdv-one]`).innerHTML = humanizeEuro(lowTax);
    this.element.querySelector(`[data-pdv-one-hidden]`).value = euroToCent(lowTax);

    this.element.querySelector(`[data-pdv-two-ratio]`).innerHTML = percentHumanize(this.pdvTwo);
    this.element.querySelector(`[data-pdv-two-ratio-hidden]`).value = this.pdvTwo;
    this.element.querySelector(`[data-pdv-two]`).innerHTML = humanizeEuro(highTax);
    this.element.querySelector(`[data-pdv-two-hidden]`).value = euroToCent(highTax);

    this.element.querySelector(`[data-income-tax-hidden]`).value = euroToCent(incomeTax);
    this.element.querySelector(`[data-income-tax]`).innerHTML = humanizeEuro(incomeTax);

    this.element.querySelector(`[data-health-insurance-ratio]`).innerHTML = percentHumanize(this.healthInsuranceInPercent);
    this.element.querySelector(`[data-health-insurance-ratio-hidden]`).value = this.healthInsuranceInPercent;
    this.element.querySelector(`[data-health-insurance]`).innerHTML = humanizeEuro(healthInsurance);
    this.element.querySelector(`[data-health-insurance-hidden]`).value = euroToCent(healthInsurance);

    this.element.querySelector(`[data-employer-to-pay-hidden]`).value = euroToCent(employerToPay);
    this.element.querySelector(`[data-employer-to-pay]`).innerHTML = humanizeEuro(employerToPay);

    this.element.querySelector(`[data-net-hidden]`).value = euroToCent(netSalary);
    this.element.querySelector(`[data-net]`).innerHTML = humanizeEuro(netSalary);
  }

  netToBrut(amountInEuro) {
    const pdvOneInPercent = this.pdvOne * 100; 
    const pdvTwoInPercent = this.pdvTwo * 100;

    const netSalary = parseFloat(amountInEuro);

    this.baseAfterPillars = financialRoundUp(netSalary - this.totalPillarInEuro);
    const desiredPersonalDeductionInEuro = this.minSalary * this.personalDeductionCoeff; // keep raw
    this.personalDeductionInEuro = financialRoundUp(
      Math.min(desiredPersonalDeductionInEuro, this.baseAfterPillars)
    );

    const kpn = (pdvOneInPercent / (100 - pdvOneInPercent) ) + 1;
    const kpv = (pdvTwoInPercent / (100 - pdvTwoInPercent) ) + 1; 
    var checkClass = this.breakingPoint * (1 / kpn) + this.personalDeductionInEuro;

    if (netSalary <= desiredPersonalDeductionInEuro) {
      var income = netSalary;
      var grossSalary = this.incomeToGross(income, netSalary)
    } else if (netSalary > desiredPersonalDeductionInEuro && netSalary <= checkClass) {    // Here could be and error
      var income = (netSalary - desiredPersonalDeductionInEuro ) * kpn + desiredPersonalDeductionInEuro;
      var grossSalary = this.incomeToGross(income, netSalary);
    } else if (netSalary > checkClass ) {
      var income = this.breakingPoint + desiredPersonalDeductionInEuro + (netSalary - (this.breakingPoint - this.breakingPoint * this.pdvOne + desiredPersonalDeductionInEuro)) * kpv;
      var grossSalary = this.incomeToGross(income, netSalary);
    } 

    this.brutToNet(grossSalary);
  }

  salaryCalculate() {
    // settings
    const amountInEuro = parseEuro(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0");
    const cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    const cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;
    // tax rates (as decimals, e.g. 0.18)
    this.pdvOne = cityTaxRate ? Number(cityTaxRate.lower_rate) : 0;
    this.pdvTwo = cityTaxRate ? Number(cityTaxRate.higher_rate) : 0;

    const kidsNum = parseInt(this.element.querySelector(`[data-kids-num-input]`)?.value || "0", 10) || 0;
    const dependentsNum = parseInt(this.element.querySelector(`[data-dependents-num-input]`)?.value || "0", 10) || 0;
    const disabilityEl = this.element.querySelector(`[data-disability-input]:checked`);
    const disability = disabilityEl ? disabilityEl.value : null;
    // deduction coefficient (not money yet)
    this.personalDeductionCoeff = this.getPersonalDeduction(kidsNum, dependentsNum, disability);

    const calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";
    if (calculatorMethod == "brut-to-net") {
      this.brutToNet(amountInEuro)
    } else if (calculatorMethod == "net-to-brut") {
      this.netToBrut(amountInEuro)
    }

  }

}
