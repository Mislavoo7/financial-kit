class User::BaseController < ApplicationController
  layout 'application'
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
    unless cookies["credit_id"].blank?
      credit = Credit.find_by_slug(cookies["credit_id"])
      current_user.credits << credit 
      # current_user doesn't have to see the login/sign up CTA under the login form
      cookies.delete "credit_id"
    end
  end
end
