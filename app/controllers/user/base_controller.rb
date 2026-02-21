class User::BaseController < ApplicationController
  layout 'application'
  before_action :authenticate_user!
  before_action :set_pages

  private

  def set_pages
    @pages = Page.where(name: [
      "home", "about"    
    ]).index_by(&:name)

    @home_page = @pages["home"]
    @about_page = @pages["about"]
  end
end
