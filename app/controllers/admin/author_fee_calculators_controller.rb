class Admin::AuthorFeeCalculatorsController < Admin::BaseController
  before_action :set_author_fee_calculator, only: [ :destroy ]

  def index
    @author_fee_calculators = AuthorFeeCalculator.all
  end

  def destroy
    if @author_fee_calculator.destroy
      redirect_to admin_author_fee_calculators_path, notice: t("message.deleted")
    else
      redirect_to admin_author_fee_calculators_path, alert: t("message.something_wrong")
    end
  end

  private

  def set_author_fee_calculator
    @author_fee_calculator = AuthorFeeCalculator.find_by_slug(params[:id])
  end
end
