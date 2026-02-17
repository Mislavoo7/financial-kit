# == Schema Information
#
# Table name: sections
#
#  id               :bigint           not null, primary key
#  is_visible       :boolean          default(TRUE)
#  position         :integer          default(1000)
#  section_type     :string           default("simple")
#  sectionable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  sectionable_id   :integer
#
require "test_helper"

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
