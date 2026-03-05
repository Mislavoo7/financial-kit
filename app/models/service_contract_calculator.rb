# == Schema Information
#
# Table name: service_contract_calculators
#
#  id               :bigint           not null, primary key
#  amount_in_cent   :integer          default(0)
#  calculation_type :string           default("brut-to-net")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  city_tax_rate_id :integer
#  user_id          :integer
#
class ServiceContractCalculator < ApplicationRecord
  include CalculationMethods
  include MoneyNormalization
  include Slugable
  include CityTaxMethods

  belongs_to :user, optional: true

  validates :amount_in_cent, :calculation_type, :city_tax_rate_id, presence: true
  validates :amount_in_cent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def money_fields
    %i[amount_in_cent]
  end

  def humanize_amount_in_cent
    humanize_euro(cents_to_euro(self.amount_in_cent))
  end

  def to_param
    slug
  end
end
