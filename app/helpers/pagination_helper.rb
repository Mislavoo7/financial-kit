module PaginationHelper
  def get_pagination_url(url)
    url_without_filter = url.gsub("/filter", "")

    param_page = url_without_filter.split("?")[-1]
    page = param_page.include?("page") ? "?#{param_page}" : "" 

    return "#{request.path.gsub("/filter", "")}#{page}"
  end
end
