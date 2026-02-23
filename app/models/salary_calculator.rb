# == Schema Information
#
# Table name: salary_calculators
#
#  id                 :bigint           not null, primary key
#  amount_in_cent     :integer          default(0)
#  calculation_type   :string           default("brut-to-net")
#  dependents_num     :integer          default(0)
#  disability         :string           default("no-disability")
#  kids_num           :integer          default(0)
#  personal_deduction :integer          default(1)
#  slug               :string           default("")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  city_tax_rate_id   :integer
#  user_id            :integer
#
class SalaryCalculator < ApplicationRecord
  include CalculationMethods
  include MoneyNormalization
  include Slugable

  belongs_to :user, optional: true

  validates :amount_in_cent, :calculation_type, :dependents_num, :disability, :kids_num, :personal_deduction, :city_tax_rate_id, presence: true
  validates :amount_in_cent, :dependents_num, :kids_num, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :personal_deduction, numericality: { greater_than_or_equal_to: 1 }, allow_nil: true

  CALCULATION_TYPE = ["brut-to-net", "net-to-brut"]
  validates :calculation_type, inclusion: { in: CALCULATION_TYPE }

  DISABILITY_TYPE = ["no-disability", "partial-disability", "total-disability"]
  validates :disability, inclusion: { in: DISABILITY_TYPE }

  def money_fields
    %i[amount_in_cent]
  end

  def humanize_amount_in_cent
    humanize_euro(cents_to_euro(self.amount_in_cent))
  end

  def to_param
    slug
  end

  def city_tax_rate
    begin
      CityTaxRate.find(self.city_tax_rate_id).title
    rescue
      "-"
    end
  end
end
