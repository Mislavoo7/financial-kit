class Admin::CityTaxRatesController < Admin::BaseController
  before_action :set_city_tax_rate, only: [:edit, :update, :destroy]

  def index
    @city_tax_rates = CityTaxRate.all
  end

  def new
    @city_tax_rate = CityTaxRate.new
  end

  def create
    @city_tax_rate = CityTaxRate.new(city_tax_rate_params)

    if @city_tax_rate.save
      redirect_to admin_city_tax_rates_path, notice: t('saved_successfully')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @city_tax_rate.update(city_tax_rate_params)
      redirect_to admin_city_tax_rates_path, notice: t('saved_successfully')
    else
      render :edit
    end
  end

  def destroy
    if @city_tax_rate.destroy
      redirect_to admin_city_tax_rates_path, notice: t('message.deleted')
    else
      redirect_to admin_city_tax_rates_path, alert: t('message.something_wrong')
    end
  end

  private

  def city_tax_rate_params
    params.require(:city_tax_rate).permit( :title, :lower_rate, :higher_rate)
  end

  def set_city_tax_rate
    @city_tax_rate = CityTaxRate.find(params[:id])
  end

end
