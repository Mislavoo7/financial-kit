class ServiceContractCalculatorsController < BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates

  def new
    @service_contract_calculator = ServiceContractCalculator.new
    @page = @pages["home"]
    @seo = @page.seo
  end

  def create
    @service_contract_calculator = ServiceContractCalculator.new(service_contract_calculator_params)

    if @service_contract_calculator.save
      if current_user
        current_user.service_contract_calculators << @service_contract_calculator
      else
        cookies["service_contract_calculator_id"] = @service_contract_calculator.slug
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
      :brut_in_cent, :taxation_base_in_cent, :employer_to_pay_in_cent,
      :first_pillar_ratio, :first_pillar_in_cent,
      :second_pillar_ratio, :second_pillar_in_cent,
      :total_pillar_in_cent, :income_tax_ratio, :income_tax_in_cent,
      :net_in_cent, :health_insurance_ratio, :health_insurance_in_cent,
    )
  end
end
