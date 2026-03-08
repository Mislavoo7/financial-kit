import { Controller } from "@hotwired/stimulus";
import { initCityAutocomplete } from "./concerns/autocomplete";
import { ratioToPercent, humanizeEuro, financialRoundUp, parseEuro, percentHumanize, euroToCent, percentToRatio } from "./concerns/calculator_helpers";

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
      onSelect: () => this.serviceContractCalculate()
    });
    this.serviceContractCalculate();
  }

  brutToNet(amountInEuro) {

    const firstPillarInEuro = amountInEuro * this.firstPillarRatio;
    const secondPillarInEuro = amountInEuro * this.secondPillarRatio;
    const totalPillarInEuro = firstPillarInEuro + secondPillarInEuro;
    const taxationBase = amountInEuro - totalPillarInEuro;

    const incomeTaxInEuro = financialRoundUp(taxationBase * this.pdvOne); 
    const healthInsuranceInEuro = financialRoundUp(amountInEuro * this.healthInsuranceRatio);
    const employerToPay = financialRoundUp(amountInEuro + healthInsuranceInEuro);
    const netSalary = financialRoundUp(taxationBase - incomeTaxInEuro);

    this.element.querySelector(`[data-brut]`).innerHTML = humanizeEuro(amountInEuro);
    this.element.querySelector(`[data-brut-hidden]`).value = euroToCent(amountInEuro);

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

  netToBrut(amountInEuro) {
    let pdvOneInPercent = ratioToPercent(this.pdvOne);
    const kpr = ((10 + 0.9 * pdvOneInPercent) / (100 - 0.9 * pdvOneInPercent - 10)) + 1
    const brutSalary = amountInEuro * kpr 
    this.brutToNet(brutSalary)
  }

  serviceContractCalculate() {
    const amountInEuro = parseEuro(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0");
    const cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    const cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;

    this.pdvOne = cityTaxRate ? Number(cityTaxRate.lower_rate) : 0;

    const calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";
    if (calculatorMethod == "brut-to-net") {
      this.brutToNet(amountInEuro)
    } else if (calculatorMethod == "net-to-brut") {
      this.netToBrut(amountInEuro)
    }
  }
}
