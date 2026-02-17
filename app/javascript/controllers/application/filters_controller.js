import { Controller } from "@hotwired/stimulus";

export default class FiltersController extends Controller {
  static targets = ["rows", "totalPrice", "dates", "shopNames", "allCheckbox", "currency"];

  connect() {
    this.totalPrice = this.totalPriceTarget;
    this.allCheckbox = this.allCheckboxTarget;

    this.rows = this.rowsTargets;
    this.dates = this.datesTargets;
    this.shopNames = this.shopNamesTargets;
    this.currency = this.currencyTargets;

    // run initial fire to start the chart
    this.fire()
  }

  // Helpers
  convertToDate(dateStr) {
    // Remove trailing dot and split by dot
    const cleaned = dateStr.replace(/\.$/, '');
    const [day, month, year] = cleaned.split('.').map(Number);
    return new Date(year, month - 1, day);
  }

  // Events
  fire() {
    let fromDate = this.convertToDate(this.dates[0].value);
    let toDate = this.convertToDate(this.dates[1].value);

    let allShopNames = this.shopNames; 
    let selectedShopNames = allShopNames.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
    let selectedPrices = allShopNames.filter(checkbox => checkbox.checked).reduce((acc, key) => ({ ...acc, [key.value]: [0, key.getAttribute("data-chart-color")] }), {});
    let totalPrice = 0;

    // check/uncheck the "all" checkbox
    this.allCheckbox.checked = allShopNames.length == selectedShopNames.length

    // got through all rows and hide what is not active
    this.rows.forEach((target) => {
      let date = this.convertToDate(target.dataset.date)
      // to be active the date of the row must be inside a range and the shop name must be checked
      let isActive = 
        selectedShopNames.includes(target.dataset.shopName) &&
        date >= fromDate && date <= toDate

      if (isActive) {
        target.classList.remove("hidden") 
        totalPrice += parseFloat( target.dataset.price );
        selectedPrices[target.getAttribute("data-shop-name")][0] += parseFloat( target.dataset.price );
      } else {
        target.classList.add("hidden");
      }
    });

    // change the total price
    this.totalPrice.innerHTML = `${totalPrice.toFixed(2)} €`

    // Update the chart - first destroy then recreate
    if (window.chartInstance) {
      window.chartInstance.destroy();
    }
    // Create a new chart
    let chartData = [];
    for (let name in selectedPrices) {
      let value =  (selectedPrices[name][0]/totalPrice)*100;
      let color = selectedPrices[name][1];
      chartData.push({title: name, value: value, color: color })
    };
    initChart(chartData)
  }

  fireAll() {
    // click on the select all checbox will select all shops and rerun the filter
    let clickedElement = event.currentTarget;
    this.shopNames.forEach((target) => {
      target.checked = clickedElement.checked;
    })

    this.fire()
  }

  firePredefinedDate() {
    let clickedElement = event.currentTarget;
    let fromDate = clickedElement.dataset.fromDate;
    let toDate = clickedElement.dataset.toDate;
    this.dates[0].value = fromDate;
    this.dates[1].value = toDate;

    this.fire()
  }
}
