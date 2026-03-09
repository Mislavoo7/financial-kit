# == Schema Information
#
# Table name: author_fee_calculators
#
#  id                          :bigint           not null, primary key
#  amount_in_cent              :integer          default(0)
#  brut_in_cent                :integer          default(0), not null
#  calculation_type            :string           default("brut-to-net")
#  contribution_base_in_cent   :integer          default(0), not null
#  employer_to_pay_in_cent     :integer          default(0), not null
#  fee_type                    :string           default("contract")
#  first_pillar_in_cent        :integer          default(0), not null
#  first_pillar_ratio          :decimal(5, 4)    default(0.0), not null
#  health_insurance_in_cent    :integer          default(0), not null
#  health_insurance_ratio      :decimal(5, 4)    default(0.0), not null
#  income_in_cent              :integer          default(0), not null
#  income_tax_in_cent          :integer          default(0), not null
#  income_tax_ratio            :decimal(5, 4)    default(0.0), not null
#  lump_sum_additional_in_cent :integer          default(0), not null
#  lump_sum_additional_ratio   :decimal(5, 4)    default(0.0), not null
#  lump_sum_in_cent            :integer          default(0), not null
#  lump_sum_ratio              :decimal(5, 4)    default(0.0), not null
#  net_in_cent                 :integer          default(0), not null
#  second_pillar_in_cent       :integer          default(0), not null
#  second_pillar_ratio         :decimal(5, 4)    default(0.0), not null
#  slug                        :string
#  taxation_base_in_cent       :integer          default(0), not null
#  total_pillar_in_cent        :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  city_tax_rate_id            :integer
#  user_id                     :integer
#
class AuthorFeeCalculator < ApplicationRecord
  include CalculationMethods
  include MoneyNormalization
  include Slugable
  include CityTaxMethods

  belongs_to :user, optional: true
  validates :amount_in_cent, :calculation_type, :fee_type, :city_tax_rate_id, presence: true
  validates :amount_in_cent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  FEE_TYPES = [ "contract", "artist-contract" ].freeze
  validates :fee_type, inclusion: { in: FEE_TYPES }

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
