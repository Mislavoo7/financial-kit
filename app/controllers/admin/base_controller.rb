class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  before_action :authenticate_admin!
  before_action :set_pages

  private

  def set_pages
    @pages = Page.all
  end
end
