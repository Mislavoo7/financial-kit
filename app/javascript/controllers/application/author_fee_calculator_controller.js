import { Controller } from "@hotwired/stimulus";
import { initCityAutocomplete } from "./concerns/city_autocomplete";
import { humanizeEuro, financialRoundUp, parseEuro, percentHumanize, euroToCent, percentToRatio } from "./concerns/calculator_helpers";

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

    this.lumpSum = 30;
    this.lumpSumAdditional = 25;
    this.firstPillar = 7.5;
    this.secondPillar = 2.5;
    this.totalPillar = this.firstPillar + this.secondPillar;
    this.healthInsurance = 7.5;

    this.lumpSumRatio = percentToRatio(this.lumpSum);
    this.lumpSumAdditionalRatio = percentToRatio(this.lumpSumAdditional);
    this.firstPillarRatio = percentToRatio(this.firstPillar);
    this.secondPillarRatio = percentToRatio(this.secondPillar);
    this.healthInsuranceRatio = percentToRatio(this.healthInsurance);

    initCityAutocomplete({
      input: this.citySearchTarget,
      hiddenInput: this.cityTaxRateIdTarget,
      data: this.cityTaxRatesValue,
      onSelect: () => this.authorFeeCalculate()
    });
    this.authorFeeCalculate();
  }

  brutToNet(amountInEuro, feeType) {
    const expense = amountInEuro * this.lumpSumRatio;
    let expenseAdditional = NaN;
    let totalExpenseInEuro = NaN;

    if (feeType == "artist-contract" ) {
      expenseAdditional = amountInEuro * this.lumpSumAdditionalRatio
      totalExpenseInEuro = expense + expenseAdditional;
    } (feeType == "contract" ) {
      totalExpenseInEuro = expense;
    }

    const contributionBase = amountInEuro - totalExpense;
    const firstPillarInEuro = contributionBase * this.firstPillarRatio;
    const secondPillarInEuro = contributionBase * this.secondPillarRatio;
    const totalPillarInEuro = firstPillarInEuro + secondPillarInEuro;
    const taxationBase = contributionBase - totalPillarInEuro;

    const incomeTaxInEuro = financialRoundUp(taxationBase * this.pdvOne); 
    const healthInsuranceInEuro = contributionBase * this.healthInsuranceRatio;
    const employerToPay = financialRoundUp(amountInEuro + healthInsuranceInEuro);
    const netSalary = financialRoundUp(taxationBase - incomeTaxInEuro + totalExpenseInEuro);

    this.element.querySelector(`[data-brut]`).innerHTML = humanizeEuro(amountInEuro);
    this.element.querySelector(`[data-brut-hidden]`).value = euroToCent(amountInEuro);


    this.element.querySelector(`[data-lump-sum-ratio]`).innerHTML = percentHumanize(this.firstPillarRatio);
    this.element.querySelector(`[data-lump-sum-ratio-hidden]`).value = this.lumpSumAdditionalRatio;
    this.element.querySelector(`[data-lump-sum]`).innerHTML = humanizeEuro(expense);
    this.element.querySelector(`[data-lump-sum-hidden]`).value = euroToCent(expense);

    this.element.querySelector(`[data-lump-sum-aditional-ratio]`).innerHTML = percentHumanize(this.firstPillarRatio);
    this.element.querySelector(`[data-lump-sum-aditional-ratio-hidden]`).value = this.lumpSumAdditionalRatio;
    this.element.querySelector(`[data-lump-sum-aditional]`).innerHTML = humanizeEuro(expenseAdditional);
    this.element.querySelector(`[data-lump-sum-aditional-hidden]`).value = euroToCent(expenseAdditional);
    this.element.querySelector(`[data-contribution-base]`).innerHTML = humanizeEuro(contributionBase);
    this.element.querySelector(`[data-contribution-base-hidden]`).value = euroToCent(contributionBase);
    this.element.querySelector(`[data-first-pillar-ratio]`).innerHTML = percentHumanize(this.firstPillarRatio);
    this.element.querySelector(`[data-first-pillar-ratio-hidden]`).value = this.firstPillarRatio;
    this.element.querySelector(`[data-first-pillar]`).innerHTML = humanizeEuro(firstPillarInEuro);
    this.element.querySelector(`[data-first-pillar-hidden]`).value = euroToCent(firstPillarInEuro);

    this.element.querySelector(`[data-second-pillar-ratio]`).innerHTML = percentHumanize(this.secondPillarRatio);
    this.element.querySelector(`[data-second-pillar-ratio-hidden]`).value = this.secondPillarRatio;
    this.element.querySelector(`[data-second-pillar]`).innerHTML = humanizeEuro(secondPillarInEuro);
    this.element.querySelector(`[data-second-pillar-hidden]`).value = euroToCent(secondPillarInEuro);
    this.element.querySelector(`[data-total-pillar]`).innerHTML = humanizeEuro(totalPillarInEuro);
    this.element.querySelector(`[data-total-pillar-hidden]`).value = euroToCent(totalPillarInEuro);
    this.element.querySelector(`[data-taxation-base]`).innerHTML = humanizeEuro(taxationBase);
    this.element.querySelector(`[data-taxation-base-hidden]`).value = euroToCent(taxationBase);

    this.element.querySelector(`[data-income-tax-ratio]`).innerHTML = percentHumanize(this.pdvOne);
    this.element.querySelector(`[data-income-tax-ratio-hidden]`).value = this.pdvOne;
    this.element.querySelector(`[data-income-tax]`).innerHTML = humanizeEuro(incomeTaxInEuro);
    this.element.querySelector(`[data-income-tax-hidden]`).value = euroToCent(incomeTaxInEuro);

    this.element.querySelector(`[data-net]`).innerHTML = humanizeEuro(netSalary);
    this.element.querySelector(`[data-net-hidden]`).value = euroToCent(netSalary);

    this.element.querySelector(`[data-health-insurance-ratio]`).innerHTML = percentHumanize(this.healthInsuranceRatio);
    this.element.querySelector(`[data-health-insurance-ratio-hidden]`).value = this.healthInsuranceRatio;
    this.element.querySelector(`[data-health-insurance]`).innerHTML = humanizeEuro(healthInsuranceInEuro);
    this.element.querySelector(`[data-health-insurance-hidden]`).value = euroToCent(healthInsuranceInEuro);

    this.element.querySelector(`[data-employer-to-pay]`).innerHTML = humanizeEuro(employerToPay);
    this.element.querySelector(`[data-employer-to-pay-hidden]`).value = euroToCent(employerToPay);
  }

  netToBrut(amountInEuro, feeType) {
    let kpr = NaN;
    if (feeType == "artist-contract" ) {
      kpr = (( 4.5 + 0.405 * this.pdvOne) / (100 - 4.5 - 0.405 * this.pdvOne)) + 1
    } else {
      kpr = (( 7 + 0.63 * this.pdvOne) / (100 - 7 - 0.63 * this.pdvOne)) + 1
    }
    const brutSalary = amountInEuro * kpr 
    brutToNet(brutSalary, feeType)
  }

  authorFeeCalculate() {
    const amountInEuro = parseEuro(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0");
    const cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    const cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;

    this.pdvOne = cityTaxRate ? Number(cityTaxRate.lower_rate) : 0;

    const feeTypeEl = this.element.querySelector(`[data-fee-type-input]:checked`);
    const feeType = feeTypeEl ? feeTypeEl.value : null;

    const calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";
    if (calculatorMethod == "brut-to-net") {
      this.brutToNet(amountInEuro, feeType)
    } else if (calculatorMethod == "net-to-brut") {
      this.netToBrut(amountInEuro)
    }
  }
}
