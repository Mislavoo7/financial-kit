class SalaryCalculatorsController < BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates

  def new
    @salary_calculator = SalaryCalculator.new
  end

  def create
    @salary_calculator = SalaryCalculator.new(salary_calculator_params)

    if @salary_calculator.save
      if current_user
        current_user.salary_calculators << @salary_calculator
      else
        cookies["salary_calculator_id"] = @salary_calculator.slug
      end
      redirect_to user_calculations_path
    else
      render :new
    end
  end

  def show
  end

  private

  def salary_calculator_params
    params.require(:salary_calculator).permit(
      :amount_in_cent, :calculation_type, :dependents_num, :disability, :kids_num, :personal_deduction, :city_tax_rate_id,

      :brut_in_cent, :first_pillar_in_cent, :second_pillar_in_cent, :total_pillar_in_cent,
      :taxation_base_in_cent, :pdv_one_in_cent, :pdv_two_in_cent, :income_tax_in_cent,
      :health_insurance_in_cent, :employer_to_pay_in_cent, :net_in_cent,

      :first_pillar_ratio, :second_pillar_ratio, :total_pillar_ratio,
      :pdv_one_ratio, :pdv_two_ratio, :health_insurance_ratio
    )
  end
end
