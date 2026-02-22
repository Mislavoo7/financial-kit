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
require "test_helper"

class CreditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
