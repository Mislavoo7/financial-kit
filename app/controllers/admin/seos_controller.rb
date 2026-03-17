class Admin::SeosController < Admin::BaseController
  before_action :set_seo, only: [ :edit, :update, :destroy ]

  def index
    @seos = Seo.all 
  end

  def new
    @seo = Seo.new
  end

  def create
    @seo = Seo.new(seo_params)
    if @seo.save
      redirect_to admin_seos_path, notice: t("message.created")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @seo.update(seo_params)
      redirect_to admin_seos_path, notice: t("saved_successfully")
    else
      render :edit
    end
  end

  def destroy
    @seo.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def seo_params
    params.require(:seo).permit(
      :image, :remove_image,
      seo_translations_attributes: [ :id, :url, :locale, :title, :description, :keywords ]
    )
  end

  def set_seo
    @seo = Seo.find(params["id"])
  end
end
