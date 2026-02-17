class PagesController < BaseController
  def index
    @page = @pages["home"]
    @seo = @page.seo
    set_sections
  end

  def show
    translation = PageTranslation.find_by!(slug: params[:id])

    @page = translation.page
    @seo  = @page.seo || Seo.new
    set_sections
  end

  private

  def set_sections
    sections = @page.sections.all_visible
    @featured_section = sections.first
    @other_sections = sections.where.not(id: @featured_section.id)
  end
end
