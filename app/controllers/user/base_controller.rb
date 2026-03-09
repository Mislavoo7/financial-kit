class User::BaseController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  before_action :set_pages
  before_action :empty_cookies

  private

  def set_pages
    @pages = Page.where(name: [
      "home", "about"
    ]).index_by(&:name)

    @home_page = @pages["home"]
    @about_page = @pages["about"]
  end

  def empty_cookies
    {
      "credit_id" => [ Credit, :credits ],
      "salary_calculator_id" => [ SalaryCalculator, :salary_calculators ],
      "author_fee_calculator_id" => [ AuthorFeeCalculator, :author_fee_calculators ],
      "service_contract_calculator_id" => [ ServiceContractCalculator, :service_contract_calculators ]
    }.each do |cookie_key, (model, association)|
      next if cookies[cookie_key].blank?

      record = model.find_by_slug(cookies[cookie_key])
      current_user.public_send(association) << record if record.present?

      cookies.delete(cookie_key)
    end
  end
end
