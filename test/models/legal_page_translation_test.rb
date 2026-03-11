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
  def build_legal_page
    legal_page = LegalPage.new(
      legal_page_translations_attributes: [
        { title: "Terms", content: "hello", locale: "en", slug: "terms" },
        { title: "Uvjeti", content: "hello", locale: "hr", slug: "uvjeti" },
        { title: "Bedingungen", content: "hello", locale: "de", slug: "bedingungen" }
      ]
    )
    legal_page.save!
    legal_page
  end

  test "is invalid without title" do
    translation = build_legal_page.legal_page_translations.first
    translation.title = nil
    assert translation.invalid?
    assert translation.errors.added?(:title, :blank)
  end

  test "default scope orders by locale descending" do
    legal_page = build_legal_page
    assert_equal ["hr", "en", "de"], legal_page.reload.legal_page_translations.pluck(:locale)
  end

  test "can have rich text content" do
    translation = build_legal_page.legal_page_translations.first
    translation.content = "<p>Hello world</p>"
    assert translation.save
    assert_equal "Hello world", translation.content.to_plain_text
  end

  # belongs_to :legal_page
  test "belongs to a legal page" do
    translation = build_legal_page.legal_page_translations.first
    assert_instance_of LegalPage, translation.legal_page
  end
end
