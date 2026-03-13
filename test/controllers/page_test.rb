require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  def create_about_page
    Page.create!(
      image: Rails.root.join("app/assets/images/seed_imgs/about.jpg").open,
      name: "about",
      page_translations_attributes: {
        0 => { title: "O projektu", locale: "hr" },
        1 => { title: "About the Project", locale: "en" },
        2 => { title: "Über das Projekt", locale: "de" }
      },
      seos_attributes: {
        0 => {
          image: Rails.root.join("app/assets/images/seed_imgs/about.jpg").open,
          seo_translations_attributes: {
            0 => {
              title: "O projektu | Financial Kit",
              description: "",
              keywords: "",
              locale: "hr"
            },
            1 => {
              title: "About | Financial Kit",
              description: "",
              keywords: "",
              locale: "en"
            },
            2 => {
              title: "Über das Projekt | Financial Kit",
              description: "",
              keywords: "",
              locale: "de"
            }
          }
        }
      }
    )

  end

  def create_home_page(position = nil)
    page = Page.create!(
      image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
      name: "home",
      page_translations_attributes: {
        0 => {
          title: "Financial Kit",
          locale: "hr"
        },
        1 => {
          title: "Financial Kit",
          locale: "en"
        },
        2 => {
          title: "Financial Kit",
          locale: "de"
        }
      },
      seos_attributes: {
        0 => {
          image: Rails.root.join("app/assets/images/seed_imgs/home.jpg").open,
          seo_translations_attributes: {
            0 => {
              title: "Financial Kit – Financijski kalkulatori za Hrvatsku",
              description: "",
              keywords: "",
              locale: "hr"
            },
            1 => {
              title: "Financial Kit – Financial Calculators for Croatia",
              description: "",
              keywords: "",
              locale: "en"
            },
            2 => {
              title: "Financial Kit – Finanzrechner für Kroatien",
              description: "",
              keywords: "",
              locale: "de"
            }
          }
        }
      }
    )
  end

  def add_sections(page, position = nil)
    attrs = {
      section_translations_attributes: [
        { title: "Visible section", locale: "en" },
        { title: "Visible section", locale: "de" },
        { title: "Vidljiva sekcija", locale: "hr" }
      ]
    }
    attrs[:position] = position unless position.nil?
    visible_section = Section.new(attrs)
    page.sections << visible_section
    visible_section.save!

    hidden_attrs = {
      is_visible: false,
      section_translations_attributes: [
        { title: "Hidden section", locale: "en" },
        { title: "Hidden section", locale: "de" },
        { title: "Skrivena sekcija", locale: "hr" }
      ]
    }
    hidden_attrs[:position] = position + 1 if position.present?
    hidden_section = Section.new(hidden_attrs)
    page.sections << hidden_section
    hidden_section.save!

    [visible_section, hidden_section]
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page
    @seo = @home_page.seo

    @home_visible_section, @home_hidden_section = add_sections(@home_page, 1)
    @about_visible_section, @about_hidden_section = add_sections(@about_page, 1)

    @home_translation = @home_page.page_translations.find_by!(locale: "hr")
    @about_translation = @about_page.page_translations.find_by!(locale: "hr")
  end

  test "show loads page by translation slug" do
    get page_path(id: @about_translation.slug)

    assert_response :success
    assert_includes response.body, "<title>O projektu"
  end

  test "show renders visible sections" do
    get page_path(id: @about_translation.slug)

    assert_response :success
    assert_includes response.body, "Vidljiva sekcija"
  end

  test "show does not render hidden sections" do
    get page_path(id: @about_translation.slug)

    assert_response :success
    assert_not_includes response.body, "Skrivena sekcija"
  end

  test "show raises not found for invalid slug" do
    get page_path(id: "nepostojeci-slug")
    assert_response :not_found
  end

  test "index loads successfully" do
    get root_path
    assert_includes response.body, "<title>Financial "
    assert_response :success
  end
end
