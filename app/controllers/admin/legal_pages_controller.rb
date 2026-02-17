class Admin::LegalPagesController < Admin::BaseController
  before_action :set_legal_page, only: [:edit, :update, :destroy, :visibility]

  def index
    @legal_pages = LegalPage.all
  end

  def new
    @legal_page = LegalPage.new
  end

  def create
    @legal_page = LegalPage.new(legal_page_params)
    if @legal_page.save
      redirect_to admin_legal_pages_path, notice: t('message.created')
    else
      render :new
    end
  end

  def update
    if @legal_page.update(legal_page_params)
      redirect_to admin_legal_pages_path, notice: t('message.updated')
    else
      render :show
    end
  end

  def destroy
    @legal_page.destroy
    respond_to do |format|
      format.js
    end
  end

  def sort
    params[:ids].each_with_index do |id, index|
      LegalPage.where(id: id).update_all(position: index + 1)
    end
  end

  def visibility
    if @legal_page.update_column(:is_visible, !@legal_page.is_visible)
      flash.now[:notice] = @legal_page.is_visible ? t("legal_page.is_now_visible") : t("legal_page.is_now_invisible")
    end
  end

  private

  def set_legal_page
    @legal_page = LegalPageTranslation.friendly.find(params[:id]).legal_page
  end

  def legal_page_params
    params.require(:legal_page).permit(
      legal_page_translations_attributes: [:id, :locale, :title, :content, :slug],
      seos_attributes: [:id, :image, :remove_image, seo_translations_attributes: [:id, :title, :description, :keywords, :locale] ], 
    )
  end
end
