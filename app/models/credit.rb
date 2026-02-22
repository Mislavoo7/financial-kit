# == Schema Information
#
# Table name: credits
#
#  id                     :bigint           not null, primary key
#  amount_in_cent         :integer          default(0)
#  calculation_method     :string           default("equal-installments")
#  interest_ratio         :decimal(5, 4)    default(0.0)
#  months_one             :integer          default(0)
#  number_of_installments :integer
#  repayment_year         :integer          default(0)
#  slug                   :string           default("")
#  start                  :integer          default(0)
#  start_at               :date
#  time_horizon           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
class Credit < ApplicationRecord
  include CalculationMethods
  include RatioNormalization
  include MoneyNormalization

  before_save :add_slug
  def add_slug
    if self.slug.blank?
      self.slug = "#{SecureRandom.hex(8)}" 
    end
  end

  belongs_to :user, optional: true

  validates :amount_in_cent, :interest_ratio, :repayment_year, :months_one, :start, :start_at, presence: true
  validates :interest_ratio, :months_one, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :amount_in_cent, :repayment_year, :start, numericality: { greater_than: 0 }, allow_nil: true

  CALCULATION_METHOD = ["equal-annuities", "equal-installments"]
  validates :calculation_method, inclusion: { in: CALCULATION_METHOD }

  def ratio_fields
    %i[interest_ratio]
  end

  def money_fields
    %i[amount_in_cent]
  end

  def humanize_interest_ratio 
    ratio_to_percent(interest_ratio)
  end

  def humanize_amount_in_cent
    humanize_euro(cents_to_euro(self.amount_in_cent))
  end

  def to_param
    slug
  end
end
