class User::BaseController < ApplicationController
  layout 'application'
  before_action :authenticate_user!
  before_action :set_pages

  private

  def set_pages
    @pages = Page.all
  end
end
