# == Schema Information
#
# Table name: legal_page_translations
#
#  id            :bigint           not null, primary key
#  locale        :string
#  slug          :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legal_page_id :integer
#
require "test_helper"

class LegalPageTranslationTest < ActiveSupport::TestCase
  def create_legal_page
    LegalPage.create!(
      legal_page_translations_attributes: [
        { title: "Privacy Policy", locale: "en", slug: "privacy-policy" },
        { title: "Nutzungsbedingungen", locale: "de", slug: "nutzungsbedingungen" },
        { title: "Politika privatnosti", locale: "hr", slug: "politika-privatnosti" }
      ]
    )
  end

  def build_translation(attrs = {})
    LegalPageTranslation.new({
      legal_page: create_legal_page,
      title: "Privacy Policy",
      locale: "en",
      slug: "privacy-policy"
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
    LegalPageTranslation.delete_all

    legal_page = create_legal_page

    assert_equal [ "hr", "en", "de" ], LegalPageTranslation.where(legal_page: legal_page).pluck(:locale)
  end

  test "can have rich text content" do
    translation = build_translation
    translation.content = "<p>Hello world</p>"

    assert translation.save
    assert_equal "Hello world", translation.content.to_plain_text
  end

  test "belongs to a legal page" do
    translation = build_translation

    assert_instance_of LegalPage, translation.legal_page
  end
end
