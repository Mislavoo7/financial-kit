class User::ServiceContractCalculatorsController < User::BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates
  before_action :set_service_contract_calculator, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @service_contract_calculator.update(service_contract_calculator_params)
      redirect_to user_calculations_path, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    @service_contract_calculator.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def service_contract_calculator_params
    params.require(:service_contract_calculator).permit(
      :amount_in_cent, :calculation_type, :fee_type, :city_tax_rate_id,
    )
  end

  def set_service_contract_calculator
    @service_contract_calculator = current_user.service_contract_calculators.find_by_slug(params["id"])
  end
end
