# == Schema Information
#
# Table name: section_translations
#
#  id         :bigint           not null, primary key
#  locale     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :integer
#
require "test_helper"

class SectionTranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
