class User::CalculationsController < User::BaseController
  def index
    @credits = current_user.credits
    @salary_calculators = current_user.salary_calculators
    @author_fee_calculators = current_user.author_fee_calculators
    @service_contract_calculators = current_user.service_contract_calculators
  end
end
