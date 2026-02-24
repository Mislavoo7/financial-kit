import { Controller } from "@hotwired/stimulus";
import autoComplete from "@tarekraafat/autocomplete.js";

export default class extends Controller {
  static targets = ["methodToggle", "citySearch", "cityTaxRateId"];
  static values = {
    cityTaxRates: Array, // [{id, title, lower_rate, higher_rate}, ...]
  };

  connect() {
    // Build fast lookup maps
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

  salaryCalculate() {
    const amountInCent = parseFloat(this.element.querySelector(`[data-amount-in-cent-input]`)?.value || "0");
    const kidsNum = parseInt(this.element.querySelector(`[data-kids-num-input]`)?.value || "0", 10);
    const dependentsNum = parseInt(this.element.querySelector(`[data-dependents-num-input]`)?.value || "0", 10);
    const disabilityEl = this.element.querySelector(`[data-disability-input]:checked`);
    const disability = disabilityEl ? disabilityEl.value : null;

    const cityTaxRateId = parseInt(this.cityTaxRateIdTarget?.value || "0", 10) || null;
    const cityTaxRate = cityTaxRateId ? this.cityTaxRateById.get(cityTaxRateId) : null;
    const lowerRate = cityTaxRate ? Number(cityTaxRate.lower_rate) : null;
    const higherRate = cityTaxRate ? Number(cityTaxRate.higher_rate) : null;
    const calculatorMethod = this.methodToggleTarget?.checked ? "brut-to-net" : "net-to-brut";

  }
}
