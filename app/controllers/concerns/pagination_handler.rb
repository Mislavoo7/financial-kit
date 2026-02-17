module PaginationHandler
  def apply_pagination(target, per_page=5, page=params[:page])
    # pagination
    if target.is_a? Array
      #paginate if array
      pag = Kaminari.paginate_array(target).page(page).per(per_page)
      @last_page = pag.total_pages

      return pag
    else
      #paginate not array
      pag = target.page(page).per(per_page)
      @last_page = pag.total_pages
      return pag
    end
  end

end
