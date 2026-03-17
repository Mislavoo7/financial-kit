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
  def create_legal_page(position = nil)
    attrs = {
      legal_page_translations_attributes: [
        { title: "Privacy Policy", locale: "en", slug: "privacy-policy" },
        { title: "Nutzungsbedingungen", locale: "de", slug: "nutzungsbedingungen" },
        { title: "Politika privatnosti", locale: "hr", slug: "politika-privatnosti" }
      ]
    }

    attrs[:position] = position unless position.nil?

    LegalPage.create!(attrs)
  end

  test "accepts nested attributes for legal_page_translations" do
    legal_page = create_legal_page

    assert_equal 3, legal_page.legal_page_translations.size

    translations = legal_page.legal_page_translations.index_by(&:locale)

    assert_equal "Privacy Policy", translations["en"].title
    assert_equal "Nutzungsbedingungen", translations["de"].title
    assert_equal "Politika privatnosti", translations["hr"].title
  end

  test "default scope orders by position ascending" do
    LegalPage.delete_all

    create_legal_page(2)
    create_legal_page(1)
    create_legal_page(3)

    assert_equal [ 1, 2, 3 ], LegalPage.pluck(:position)
  end

  test "assigns position automatically when not provided" do
    legal_page = create_legal_page

    assert legal_page.position.present?
    assert legal_page.position > 0
  end

  test "is_visible defaults to true" do
    legal_page = create_legal_page

    assert_equal true, legal_page.is_visible
  end

  test "can be set to not visible" do
    legal_page = create_legal_page

    legal_page.update!(is_visible: false)

    assert_equal false, legal_page.reload.is_visible
  end

  test "destroying legal page destroys all associated translations" do
    legal_page = create_legal_page
    translation_ids = legal_page.legal_page_translations.pluck(:id)

    assert_difference("LegalPageTranslation.count", -3) do
      legal_page.destroy
    end

    assert_empty LegalPageTranslation.where(id: translation_ids)
  end
end
