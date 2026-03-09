class AuthorFeeCalculatorsController < BaseController
  include CityTaxRateHandler
  before_action :set_city_tax_rates

  def new
    @author_fee_calculator = AuthorFeeCalculator.new
  end

  def create
    @author_fee_calculator = AuthorFeeCalculator.new(author_fee_calculator_params)

    if @author_fee_calculator.save
      if current_user
        current_user.author_fee_calculators << @author_fee_calculator
      else
        cookies["author_fee_calculator_id"] = @author_fee_calculator.slug
      end
      redirect_to user_calculations_path
    else
      render :new
    end
  end

  def show
  end

  private

  def author_fee_calculator_params
    params.require(:author_fee_calculator).permit(
      :amount_in_cent, :calculation_type, :fee_type, :city_tax_rate_id,
      :brut_in_cent, :contribution_base_in_cent, :net_in_cent,
      :lump_sum_ratio, :lump_sum_in_cent, :lump_sum_additional_ratio, :lump_sum_additional_in_cent,
      :first_pillar_ratio, :first_pillar_in_cent, :second_pillar_ratio, :second_pillar_in_cent, :total_pillar_in_cent,
      :income_tax_ratio, :income_tax_in_cent, :taxation_base_in_cent, :income_in_cent,
      :health_insurance_ratio, :health_insurance_in_cent,
      :employer_to_pay_in_cent
    )
  end
end
