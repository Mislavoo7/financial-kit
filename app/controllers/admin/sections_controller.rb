class Admin::SectionsController < Admin::BaseController
  before_action :set_page
  before_action :set_section, only: [:edit, :update, :destroy, :visibility]

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    @page.sections << @section

    if @section.save
      redirect_to admin_page_path(@page), notice: t('saved_successfully')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to admin_page_path(@page), notice: t('saved_successfully')
    else
      render :edit
    end
  end

  def destroy
    @section.destroy
    respond_to do |format|
      format.js
    end
  end

  def sort
    params[:ids].each_with_index do |id, index|
      Section.where(id: id).update_all(position: index + 1)
    end
  end

  def visibility
    if @section.update_column(:is_visible, !@section.is_visible)
      flash.now[:notice] = @section.is_visible ? t('section.is_now_visible') : t('section.is_now_invisible')
    end
  end

  private

  def section_params
    params.require(:section).permit(
      :section_type,
      section_translations_attributes: [:id, :locale, :title, :content]
    )
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def set_page
    begin
      @page = PageTranslation.find_by_slug(params[:page_id]).page
    rescue
      @page = Page.find(params[:page_id])
    end
    @return_url = admin_page_path(@page)
  end
end
