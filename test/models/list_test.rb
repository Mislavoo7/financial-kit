# == Schema Information
#
# Table name: lists
#
#  id                  :bigint           not null, primary key
#  currency            :string           default("€")
#  is_visible          :boolean          default(TRUE)
#  position            :integer          default(1000)
#  shop_name           :string
#  taken_at            :datetime
#  total_price_in_cent :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#
require "test_helper"

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
