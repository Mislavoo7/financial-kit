module CityTaxMethods
  def city_tax_rate
    begin
      CityTaxRate.find(self.city_tax_rate_id).title
    rescue
      "-"
    end
  end
end
