module CityTaxRateHandler
  def set_city_tax_rates
    @city_tax_rates = CityTaxRate.all.map { |r|
      { id: r.id, title: r.title, lower_rate: r.lower_rate.to_f, higher_rate: r.higher_rate.to_f }
    }.to_json
  end
end
