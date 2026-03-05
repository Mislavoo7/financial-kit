class User::AuthorFeeCalculatorsController < User::BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates
  before_action :set_author_fee_calculator, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @author_fee_calculator.update(author_fee_calculator_params)
      redirect_to user_calculations_path, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    @author_fee_calculator.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def author_fee_calculator_params
    params.require(:author_fee_calculator).permit(
      :amount_in_cent, :calculation_type, :fee_type, :city_tax_rate_id,
    )
  end

  def set_author_fee_calculator
    @author_fee_calculator = current_user.author_fee_calculators.find_by_slug(params["id"])
  end
end
