# == Schema Information
#
# Table name: seos
#
#  id           :bigint           not null, primary key
#  image        :string
#  position     :integer          default(0)
#  seoable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  seoable_id   :integer
#
require "test_helper"

class SeoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
