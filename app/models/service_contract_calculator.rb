# == Schema Information
#
# Table name: service_contract_calculators
#
#  id                       :bigint           not null, primary key
#  amount_in_cent           :integer          default(0)
#  brut_in_cent             :integer
#  calculation_type         :string           default("brut-to-net")
#  employer_to_pay_in_cent  :integer
#  first_pillar_in_cent     :integer
#  first_pillar_ratio       :decimal(5, 4)
#  health_insurance_in_cent :integer
#  health_insurance_ratio   :decimal(5, 4)
#  income_tax_in_cent       :integer
#  income_tax_ratio         :decimal(5, 4)
#  net_in_cent              :integer
#  second_pillar_in_cent    :integer
#  second_pillar_ratio      :decimal(5, 4)
#  slug                     :string
#  taxation_base_in_cent    :integer
#  total_pillar_in_cent     :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  city_tax_rate_id         :integer
#  user_id                  :integer
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

  def humanize_brut_in_cent
    humanize_euro(cents_to_euro(self.brut_in_cent))
  end

  def humanize_net_in_cent
    humanize_euro(cents_to_euro(self.net_in_cent))
  end

  def to_param
    slug
  end
end
