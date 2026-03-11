# == Schema Information
#
# Table name: legal_pages
#
#  id         :bigint           not null, primary key
#  is_visible :boolean          default(TRUE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LegalPageTest < ActiveSupport::TestCase
  def build_legal_page(position=nil) 
    LegalPage.create!(
      position: position, 
      legal_page_translations_attributes: [
        { title: "Privacy Policy", locale: "en", slug: "privacy-policy" },
        { title: "Nutzungsbedingungen", locale: "de", slug: "nutzungsbedingungen" }, 
        { title: "Politika privatnosti", locale: "hr", slug: "politika-privatnosti" }
      ]
    )
  end

  test "accepts nested attributes for legal_page_translations" do
    legal_page = build_legal_page

    assert_equal 3, legal_page.legal_page_translations.size

    titles = legal_page.legal_page_translations.map(&:title)

    assert_includes titles, "Privacy Policy"
    assert_includes titles, "Politika privatnosti"
    assert_includes titles, "Nutzungsbedingungen"
  end

  test "default scope orders by position ascending" do
    second = build_legal_page(2)
    first = build_legal_page(1)
    third = build_legal_page(3)

    assert_equal [first, second, third], LegalPage.all.to_a
  end

  test "legal page must have some position greater then 0" do
    legal_page = build_legal_page

    assert_not legal_page.position <= 0
  end

  test "is invalid without title" do
    translation = build_legal_page.legal_page_translations.first
    translation.title = nil
    assert translation.invalid?
    assert translation.errors.added?(:title, :blank)
  end

  test "can have rich text content" do
    translation = build_legal_page.legal_page_translations.first
    translation.content = "<p>Hello world</p>"
    assert translation.save
    assert_equal "Hello world", translation.content.to_plain_text
  end

  test "belongs to a legal page" do
    translation = build_legal_page.legal_page_translations.first
    assert_instance_of LegalPage, translation.legal_page
  end


  test "default scope orders by locale descending" do
    legal_page = build_legal_page
    locales = LegalPageTranslation.where(legal_page: legal_page).pluck(:locale)
    assert_equal ["hr", "en", "de"], locales
  end


  test "destroying legal page destroys all associated translations" do
    legal_page = build_legal_page 
    translation_ids = legal_page.legal_page_translations.pluck(:id)

    assert_difference("LegalPageTranslation.count", -3) do
      legal_page.destroy
    end

    assert_empty LegalPageTranslation.where(id: translation_ids)
  end
end
