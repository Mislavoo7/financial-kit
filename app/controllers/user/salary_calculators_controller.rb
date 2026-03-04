class User::SalaryCalculatorsController < User::BaseController
  before_action :set_city_tax_rates
  before_action :set_salary_calculator, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @salary_calculator.update(salary_calculator_params)
      redirect_to user_calculations_path, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    @salary_calculator.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_city_tax_rates
    @city_tax_rates = CityTaxRate.all.map { |r|
      { id: r.id, title: r.title, lower_rate: r.lower_rate.to_f, higher_rate: r.higher_rate.to_f }
    }.to_json
  end

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

  def set_salary_calculator
    @salary_calculator = current_user.salary_calculators.find_by_slug(params["id"])
  end
end
