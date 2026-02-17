class Admin::PagesController < Admin::BaseController
  before_action :set_page, only: [:edit, :update, :visibility, :show]

  def index
    @page = Page.find_by_name("home")
    @sections = @page.sections
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to "#{admin_page_path(@page)}", notice: t('saved_successfully')
    else
      render :edit
    end
  end

  def sort
    params[:ids].each_with_index do |id, index|
      Page.where(id: id).update_all(position: index + 1)
    end
  end

  def visibility
    if @page.update_column(:is_visible, !@page.is_visible)
      flash.now[:notice] = @page.is_visible ? t("page.is_now_visible") : t("page.is_now_invisible")
    end
  end

  def show
    @sections = @page.sections
  end

  private

  def page_params
    params.require(:page).permit(
      :image, :remove_image,
      page_translations_attributes: [:id, :locale, :title, :slug],
      seos_attributes: [:id, :image, :remove_image, seo_translations_attributes: [:id, :title, :description, :keywords, :locale] ], 
    )
  end

  def set_page
    @page = Page.findy_by_slug(params["id"])
  end
end
