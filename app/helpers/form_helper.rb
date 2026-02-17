module FormHelper

  def error_placeholder(object, attribute)
    if object.errors[attribute].any?
      "<div class='error-placeholder'>" \
        "<span class='validation-error'>" \
          "#{object.errors[attribute].join(', ')}" \
        "</span>" \
      "</div>".html_safe
    end
  end

  def document_field(f, name)
    accept_types = accept_file_extensions_for(f.object.class.uploaders[name])

    button = button_tag(t('document_field.add_document'), type: :button, onclick: "this.closest('.document-upload-field').querySelector('input[type=file]').click();")
    file_name_span = content_tag(:p, f.object.send("#{name}_cache")&.split("/")&.last || t('document_field.no_file_chosen'), class: 'document-name', data: { file_name: true })
    allowed_file_types = content_tag(:div, t('document_field.allowed_file_types', file_types: accept_types.upcase), class: 'upload-instructions')
    file_field = f.file_field(name, tabindex: '-1', accept: accept_types)
    cache_field = f.hidden_field("#{name}_cache")

    "<div class='document-upload' data-controller='file-document-field'>" \
      "#{allowed_file_types}" \
      "<div class='document-upload-field'>" \
        "#{button}" \
        "<div class='relative w-full'>" \
          "#{cache_field}" \
          "#{file_field}" \
          "#{file_name_span}" \
        "</div>" \
      "</div>" \
      "#{error_placeholder(f.object, name)}" \
    "</div>".html_safe
  end

  def image_field(f, name, options={})
    accept_types = accept_file_extensions_for(f.object.class.uploaders[name])
    object_fit = options[:object_fit] || 'cover'
    wrapper_class = options[:wrapper_class] || 'w-full'
    object_class = options[:object_class] || 'h-64 w-full rounded-lg '

    unless options[:width].blank? || options[:height].blank?
      options[:optimal_size] = "#{options[:width]}x#{options[:height]}px"
    end


    file_field = f.file_field(name, tabindex: '-1', accept: accept_types)
    cache_field = f.hidden_field("#{name}_cache")
    cached_image = f.object.send("#{name}_url")

    image_html = cached_image ? "<img src='#{cached_image}' data-image-preview class='#{object_class}' style='object-fit: #{object_fit}'>" : ""

   f.label name, class: "image-upload #{wrapper_class} ", style: "object-fit: #{object_fit}", tabindex: '0', data: { controller: 'form-image-field' } do
      "#{image_html}" \
      "<div class='image-upload-field #{object_class}'>" \
        "#{file_field}" \
        "#{cache_field}" \
        "#{phosphor_icon 'image', class: 'image-icon'}" \
        "<p class='image-instructions'>" \
          "<span class='font-semibold'>#{t('image_upload.click_to_browse')}</span> #{t('image_upload.or_drop')}" \
        "</p>" \
        "<p class='image-details'>" \
          "#{accept_types.gsub('.', '').upcase}" \
          " #{ "(#{t('image_upload.optimal_size', optimal_size: options[:optimal_size])})" unless options[:optimal_size].blank? }" \
        "</p>" \
      "</div>".html_safe
    end
  end

  def accept_file_extensions_for(uploader, separator: ', ')
    uploader.new.extension_allowlist.map{ |e| ".#{e}" }.join(separator)
  end

  def link_to_add_fields(form, assoc, options={}, &block)
    new_o = form.object.send(assoc).klass.new
    id = new_o.object_id
    fields = form.fields_for(assoc, new_o, child_index: id) do |ff|
      render(assoc.to_s.singularize + '_fields', f: ff)
    end
    link_to '#', class: "#{options[:classes]}", data: { id: id, add_nested_fields: '', fields: fields.gsub("\n", ''), wrapper: options[:wrapper] } do
      capture(&block)
    end
  end
end
