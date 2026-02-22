class CreditsController < BaseController
  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new(credit_params)

    if @credit.save
      if current_user
        current_user.credits << @credit
      else
        cookies['credit_id'] = @credit.slug
      end
      redirect_to user_calculations_path
    else
      render :new
    end
  end

  def show
  end

  private

  def credit_params
    params.require(:credit).permit(
      :calculation_method, :amount_in_cent, :interest_ratio, :repayment_year, :months_one, :months_two, :start, :number_of_installments, :time_horizon, :start_at
    )
  end
end
