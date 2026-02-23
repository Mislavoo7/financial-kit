class SalaryCalculatorsController < BaseController
  def new
    @salary_calculator = SalaryCalculator.new
  end

  def create
    @salary_calculator = SalaryCalculator.new(salary_calculator_params)

    if @salary_calculator.save
      if current_user
        current_user.salary_calculators << @salary_calculator
      else
        cookies['salary_calculator_id'] = @salary_calculator.slug
      end
      redirect_to user_salary_calculators_path
    else
      render :new
    end
  end

  def show
  end

  private

  def salary_calculator_params
    params.require(:salary_calculator).permit(
      :amount_in_cent, :calculation_type, :dependents_num, :disability, :kids_num, :personal_deduction, :city_tax_rate_id
    )
  end
end
