import { Application } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import SortWithUpdateController from "./sort_with_update_controller"
import NoticesController from "./notices_controller";
import CreditController from "./credit_controller";
import SalaryCalculatorController from "./salary_calculator_controller";
import AuthorFeeCalculatorController from "./author_fee_calculator_controller";
import ServiceContractCalculatorController from "./service_contract_controller";

//import NoticesController from "./notices_controller";
Rails.start()

export function startApplication() {
  const application = Application.start()
  application.debug = false
  window.AdminStimulus = application

  application.register("sort-with-update", SortWithUpdateController)
  application.register("credit", CreditController)
  application.register("salary-calculator", SalaryCalculatorController);
  application.register("author-fee-calculator", AuthorFeeCalculatorController);
  application.register("service-contract-calculator", ServiceContractCalculatorController);
  application.register("notices", NoticesController);
}
