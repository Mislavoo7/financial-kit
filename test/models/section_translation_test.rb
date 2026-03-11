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
  def create_section
    Section.create!(
      section_translations_attributes: [
        { title: "Introduction", locale: "en" },
        { title: "Einführung", locale: "de" },
        { title: "Uvod", locale: "hr" }
      ]
    )
  end

  def build_translation(attrs = {})
    SectionTranslation.new({
      section: create_section,
      title: "Introduction",
      locale: "en"
    }.merge(attrs))
  end

  test "is valid with valid attributes" do
    translation = build_translation

    assert translation.valid?
  end

  test "is invalid without title" do
    translation = build_translation(title: nil)

    assert translation.invalid?
    assert translation.errors.added?(:title, :blank)
  end

  test "default scope orders by locale descending" do
    SectionTranslation.delete_all

    section = create_section

    assert_equal ["hr", "en", "de"], SectionTranslation.where(section: section).pluck(:locale)
  end

  test "can have rich text content" do
    translation = build_translation
    translation.content = "<p>Hello world</p>"

    assert translation.save
    assert_equal "Hello world", translation.content.to_plain_text
  end

  test "belongs to a section" do
    translation = build_translation

    assert_instance_of Section, translation.section
  end
end
