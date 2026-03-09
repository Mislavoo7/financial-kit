class Admin::ServiceContractCalculatorsController < Admin::BaseController
  before_action :set_service_contract_calculator, only: [ :destroy ]

  def index
    @service_contract_calculators = ServiceContractCalculator.all
  end

  def destroy
    if @service_contract_calculator.destroy
      redirect_to admin_service_contract_calculators_path, notice: t("message.deleted")
    else
      redirect_to admin_service_contract_calculators_path, alert: t("message.something_wrong")
    end
  end

  private

  def set_service_contract_calculator
    @service_contract_calculator = ServiceContractCalculator.find_by_slug(params[:id])
  end
end
