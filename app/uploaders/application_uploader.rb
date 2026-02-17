class ApplicationUploader < CarrierWave::Uploader::Base

  after :remove, :delete_empty_upstream_dirs

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path)

    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path)
  rescue SystemCallError
    true
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "#{base_store_dir}/#{model.id}"
  end

  def base_store_dir
    "uploads/#{Rails.application.class.module_parent_name.parameterize}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
