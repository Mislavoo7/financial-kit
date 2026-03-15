require "application_system_test_case"

class ServiceContractCalculatorsTest < ApplicationSystemTestCase
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

  test "guest calculates net to brut service contract" do
    visit "/hr/service_contract_calculators/new"

    fill_in "service_contract_calculator_amount_in_cent", with: "10000"

    page.execute_script <<~JS
      const cityField = document.getElementById('service_contract_calculator_city_tax_rate_id');
      cityField.value = '319';
      cityField.dispatchEvent(new Event('input', { bubbles: true }));
      cityField.dispatchEvent(new Event('change', { bubbles: true }));
    JS

    page.execute_script <<~JS
      const toggle = document.getElementById('service_contract_calculator_calculation_type');
      if (toggle.checked) toggle.click();
    JS

    assert_selector "[data-brut]", text: "13.888,89€"
    assert_selector "[data-first-pillar]", text: "1.041,67€"
    assert_selector "[data-second-pillar]", text: "347,22€"
    assert_selector "[data-total-pillar]", text: "1.388,89€"
    assert_selector "[data-income-tax]", text: "2.500,00€"
    assert_selector "[data-taxation-base]", text: "12.500,00€"
    assert_selector "[data-net]", text: "10.000,00€"
    assert_selector "[data-health-insurance]", text: "1.041,67€"
    assert_selector "[data-employer-to-pay]", text: "14.930,56€"

    assert_selector "input#service_contract_calculator_net_in_cent[value='1000000']", visible: false
    assert_selector "input#service_contract_calculator_income_tax_in_cent[value='250000']", visible: false
    assert_selector "input#service_contract_calculator_health_insurance_in_cent[value='104167']", visible: false
    assert_selector "input#service_contract_calculator_employer_to_pay_in_cent[value='1493056']", visible: false
  end
end
