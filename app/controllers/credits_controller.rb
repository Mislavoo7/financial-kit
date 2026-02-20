class CreditsController < BaseController
  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new(credit_params)

    if @credit.save
      redirect_to root_path, notice: t("message.created")
    else
      render :new
    end
  end

  private

  def credit_params
    params.require(:credit).permit(
      :calculation_method, :amount_in_cent, :interest_ratio, :repayment_year, :months_one, :months_two, :start, :number_of_installments, :time_horizon, :start_at
    )
  end
end
