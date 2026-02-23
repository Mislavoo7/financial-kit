class Admin::CreditsController < Admin::BaseController
  before_action :set_credit, only: [:destroy]

  def index
    @credits = Credit.all 
  end

  def destroy
    if @credit.destroy
      redirect_to admin_credits_path, notice: t('message.deleted')
    else
      redirect_to admin_credits_path, alert: t('message.something_wrong')
    end
  end

  private

  def set_credit
    @credit = Credit.find_by_slug(params[:id])
  end
end

