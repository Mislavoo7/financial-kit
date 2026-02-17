# == Schema Information
#
# Table name: names
#
#  id             :bigint           not null, primary key
#  countries      :string           default([]), is an Array
#  description_de :text
#  description_en :text
#  description_hr :text
#  gender         :string
#  name           :string
#  popularity     :integer          default(0)
#  times_saved    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class NameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
