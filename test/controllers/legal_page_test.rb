require "test_helper"

class LegalPagesControllerTest < ActionDispatch::IntegrationTest
  def create_about_page(position = nil)
    attrs = {
      name: "about",
      page_translations_attributes: [
        { title: "About Us", locale: "en" },
        { title: "Über uns", locale: "de" },
        { title: "O nama", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def create_home_page(position = nil)
    attrs = {
      name: "home",
      page_translations_attributes: [
        { title: "Financial Kit", locale: "en" },
        { title: "Financial Kit", locale: "de" },
        { title: "Financial Kit", locale: "hr" }
      ]
    }

    attrs[:position] = position unless position.nil?

    Page.create!(attrs)
  end

  def create_legal_page(position = nil)
    page = LegalPage.create!(
      legal_page_translations_attributes: {
        0 => {
          title: "Uvjeti korištenja",
          locale: "hr",
          content: "<p> hi </h1>"
        },
        1 => {
          title: "Terms of Use",
          locale: "en",
          content: "<p> hi </p>"
        },
        2 => {
          title: "Nutzungsbedingungen",
          locale: "de",
          content: "<p> hi </p>"
        }
      },
      seos_attributes: {
        0 => {
          image: Rails.root.join("app/assets/images/seed_imgs/legal.jpg").open,
          seo_translations_attributes: {
            0 => {
              title: "Financial Kit – Uvjeti korištenja",
              description: "",
              keywords: "Financial Kit",
              locale: "hr"
            },
            1 => {
              title: "Financial Kit – Terms of Use",
              description: "",
              keywords: "Financial Kit",
              locale: "en"
            },
            2 => {
              title: "Financial Kit – Nutzungsbedingungen",
              description: "",
              keywords: "Financial Kit",
              locale: "de"
            }
          }
        }
      }
    )
  end

  def setup
    @legal_page = create_legal_page
    @page_translation = @legal_page.legal_page_translations.find_by!(locale: "hr")
    @seo = @legal_page.seo
    @home_page = create_home_page
    @about_page = create_about_page
  end

  test "show loads legal page by translation slug and has seo" do
    get legal_page_path(id: @page_translation.slug)
    assert_includes response.body, "<title>Financial Kit"
    assert_response :success
  end

  test "show raises not found for invalid slug" do
    get legal_page_path(id: "nepostojeci-slug")
    assert_response :not_found
  end
end
