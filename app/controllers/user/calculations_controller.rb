class User::CalculationsController < User::BaseController
  def index
    @credits = Credit.all
  end
end
