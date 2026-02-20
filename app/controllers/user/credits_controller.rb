class User::CreditsController < User::BaseController
  before_action :set_credit, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @credit.update(credit_params)
      redirect_to user_credits_path, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    @legal_page.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def credit_params
    params.require(:credit).permit(
      :calculation_method, :amount_in_cent, :interest_ratio, :repayment_year, :months_one, :months_two, :start, :number_of_installments, :time_horizon, :start_at
    )
  end

  def set_credit
    @credit = current_user.find(:id)
  end
end
