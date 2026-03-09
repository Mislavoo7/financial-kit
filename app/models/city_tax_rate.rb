# == Schema Information
#
# Table name: city_tax_rates
#
#  id          :bigint           not null, primary key
#  higher_rate :decimal(5, 4)
#  lower_rate  :decimal(5, 4)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CityTaxRate < ApplicationRecord
  include CalculationMethods
  include RatioNormalization

  validates :title, :higher_rate, :lower_rate, presence: true
  validates :higher_rate, :lower_rate, numericality: { greater_than: 0 }, allow_nil: true

  default_scope { order(:title) }

  def ratio_fields
    %i[higher_rate lower_rate]
  end

  def humanize_higher_rate
    ratio_to_percent(higher_rate)
  end

  def humanize_lower_rate
    ratio_to_percent(lower_rate)
  end
end
