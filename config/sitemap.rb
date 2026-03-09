SitemapGenerator::Sitemap.default_host = "https://financialkit.eu/"

SitemapGenerator::Sitemap.create do
  routes = Rails.application.routes.routes.map do |route|
    { alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action] }
  end

  banned_controllers = [ "rails/info",  nil ]

  # remove admin
  banned_paths = [ "admin" ]
  banned_paths.each do |banned_path|
    routes.reject! { |route| route[:path].include? banned_path }
  end

  # sitemap_generator includes root by default; prevent duplication
  routes.reject! { |route| route[:path] == "/" }

  # rm custom routes
  routes.reject! { |route| route[:path].include?("locale") or route[:path].include?("mailers") or route[:action] == "create" or route[:action] == "update" or route[:action] == "validate" or route[:path].include?("tinymce") }

  # reject orphaned pages
  routes.reject! { |route| route[:path].include?(":id") or route[:path].include?("toolkit") or route[:path].include?("/422") or route[:path].include?("/500") or route[:path].include?("/404") }

  # Strips off '(.:format)
  routes.each { |route| add route[:path][0..-11] }


  LegalPage.all_visible.each do |i|
    add legal_page_path(id: i.to_param), lastmod: i.created_at
  end

  Page.all_visible.each do |i|
    add page_path(id: i.to_param), lastmod: i.created_at
  end
end
