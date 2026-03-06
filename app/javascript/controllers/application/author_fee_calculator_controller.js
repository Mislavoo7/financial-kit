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
      expenseAdditional = amountInEuro * this.lumpSumAdditionalIRatio
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
    const healthInsuranceInEuro = contributionBase * healthInsuranceRatio;
    const employerToPay = financialRoundUp(amountInEuro + healthInsuranceInEuro);
    const netSalary = financialRoundUp(taxationBase - incomeTaxInEuro + totalExpenseInEuro);

    // TODO check InEuro vs InCent
    // TODO continue with dom fill
  }

  netToBrut(amountInEuro, feeType) { }

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
