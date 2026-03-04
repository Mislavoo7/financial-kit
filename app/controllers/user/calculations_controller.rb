class User::CalculationsController < User::BaseController
  def index
    @credits = current_user.credits
    @salary_calculators = current_user.salary_calculators
  end
end
