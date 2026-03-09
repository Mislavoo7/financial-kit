# == Schema Information
#
# Table name: salary_calculators
#
#  id                       :bigint           not null, primary key
#  amount_in_cent           :integer          default(0)
#  brut_in_cent             :integer          default(0), not null
#  calculation_type         :string           default("brut-to-net")
#  dependents_num           :integer          default(0)
#  disability               :string           default("no-disability")
#  employer_to_pay_in_cent  :integer          default(0), not null
#  first_pillar_in_cent     :integer          default(0), not null
#  first_pillar_ratio       :decimal(5, 4)    default(0.0), not null
#  health_insurance_in_cent :integer          default(0), not null
#  health_insurance_ratio   :decimal(5, 4)    default(0.0), not null
#  income_tax_in_cent       :integer          default(0), not null
#  kids_num                 :integer          default(0)
#  net_in_cent              :integer          default(0), not null
#  pdv_one_in_cent          :integer          default(0), not null
#  pdv_one_ratio            :decimal(5, 4)    default(0.0), not null
#  pdv_two_in_cent          :integer          default(0), not null
#  pdv_two_ratio            :decimal(5, 4)    default(0.0), not null
#  personal_deduction       :integer          default(1)
#  second_pillar_in_cent    :integer          default(0), not null
#  second_pillar_ratio      :decimal(5, 4)    default(0.0), not null
#  slug                     :string           default("")
#  taxation_base_in_cent    :integer          default(0), not null
#  total_pillar_in_cent     :integer          default(0), not null
#  total_pillar_ratio       :decimal(5, 4)    default(0.0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  city_tax_rate_id         :integer
#  user_id                  :integer
#
class SalaryCalculator < ApplicationRecord
  include CalculationMethods
  include MoneyNormalization
  include Slugable
  include CityTaxMethods

  belongs_to :user, optional: true

  validates :amount_in_cent, :calculation_type, :dependents_num, :disability, :kids_num, :personal_deduction, :city_tax_rate_id, presence: true
  validates :amount_in_cent, :dependents_num, :kids_num, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :personal_deduction, numericality: { greater_than_or_equal_to: 1 }, allow_nil: true

  DISABILITY_TYPE = [ "no-disability", "partial-disability", "total-disability" ].freeze
  validates :disability, inclusion: { in: DISABILITY_TYPE }

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
