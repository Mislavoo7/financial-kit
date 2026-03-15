require "application_system_test_case"

class AuthorFeeCalculatorsTest < ApplicationSystemTestCase
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

    page
  end

  def setup
    @home_page = create_home_page
    @about_page = create_about_page
    @seo = @home_page.seo

    @city_tax_rate = CityTaxRate.create!(
      id: 319,
      title: "Osijek",
      higher_rate: 30,
      lower_rate: 20
    )
  end

test "guest calculates net to brut author fee for artist contract" do
  visit "/hr/author_fee_calculators/new"

  fill_in "author_fee_calculator_amount_in_cent", with: "10000"
  choose "author_fee_calculator_fee_type_artist_contract"

  page.execute_script <<~JS
    const cityField = document.getElementById('author_fee_calculator_city_tax_rate_id');
    cityField.value = '319';
    cityField.dispatchEvent(new Event('input', { bubbles: true }));
    cityField.dispatchEvent(new Event('change', { bubbles: true }));
  JS

  page.execute_script <<~JS
    const toggle = document.getElementById('author_fee_calculator_calculation_type');
    if (toggle.checked) toggle.click();
  JS

  assert_selector "[data-brut]", text: "11.441,65€"
  assert_selector "[data-net]", text: "10.000,00€"
  assert_selector "[data-employer-to-pay]", text: "11.827,81€"

  assert_selector "[data-lump-sum]", text: "3.432,49€"
  assert_selector "[data-lump-sum-additional]", text: "2.860,41€"
  assert_selector "[data-contribution-base]", text: "5.148,74€"
  assert_selector "[data-income-tax]", text: "926,77€"
  assert_selector "[data-health-insurance]", text: "386,16€"

  assert_selector "input#author_fee_calculator_net_in_cent[value='1000000']", visible: false
  assert_selector "input#author_fee_calculator_income_tax_in_cent[value='92677']", visible: false
  assert_selector "input#author_fee_calculator_health_insurance_in_cent[value='38616']", visible: false
  assert_selector "input#author_fee_calculator_employer_to_pay_in_cent[value='1182781']", visible: false
end
end
