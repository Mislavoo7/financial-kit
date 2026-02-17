module SeoHelper

  def assemble_canonical(fullpath=request.fullpath, options)
    options = {} if options.blank?
    base_url = options[:base_url] || request.base_url
    parsed_url = Addressable::URI.parse(URI.join(base_url, fullpath))
    params = parsed_url.query_values
    parsed_url.query_values = params&.slice(*options[:allow_params].map(&:to_s)) unless options[:allow_params] == :all
    parsed_url.to_s.chomp("?").chomp("/")
  end

  def seo_description(desc)
    # will return SEO description (string) without tags and max 150 in length
    # use: <%= seo_description(@news_item.description) %> 
    truncate(strip_tags(desc), length: 150 ) unless desc.blank?
  end

  def seo_keywords(keywords)
    # will return SEO keywords (string)
    # use: <%= seo_keywords( @news_item.tags.pluck(:title).join(', ') ) %> 
    keywords unless keywords.blank?
  end

  def seo_image_path(img)
    if img.include?("storage.googleapis")
      img
    else
      image_path(img)
    end

  end


end
