class ServiceContractCalculatorsController < BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates

  def new
    @service_contract_calculator = ServiceContractCalculator.new
  end

  def create
    @service_contract_calculator = ServiceContractCalculator.new(service_contract_calculator_params)

    if @service_contract_calculator.save
      if current_user
        current_user.service_contract_calculators << @service_contract_calculator
      else
        cookies['service_contract_calculator_id'] = @service_contract_calculator.slug
      end
      redirect_to user_calculations_path
    else
      render :new
    end
  end

  def show
  end

  private

  def service_contract_calculator_params
    params.require(:service_contract_calculator).permit(
      :amount_in_cent, :calculation_type, :city_tax_rate_id,
    )
  end
end
