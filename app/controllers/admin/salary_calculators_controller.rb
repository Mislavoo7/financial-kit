class Admin::SalaryCalculatorsController < Admin::BaseController
  before_action :set_salary_calculator, only: [:destroy]

  def index
    @salary_calculators = SalaryCalculator.all 
  end

  def destroy
    if @salary_calculator.destroy
      redirect_to admin_salary_calculators_path, notice: t('message.deleted')
    else
      redirect_to admin_salary_calculators_path, alert: t('message.something_wrong')
    end
  end

  private

  def set_salary_calculator
    @salary_calculator = SalaryCalculator.find_by_slug(params[:id])
  end
end

