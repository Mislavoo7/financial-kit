class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick
  include CarrierWave::ImageOptimizer

  process resize_to_limit: [3840, nil]
  # process optimize: [{ quality: 50 }]

  version :thumb do
    process resize_to_limit: [200, nil]
  end

  version :medium do
    process resize_to_limit: [800, nil]
  end

  version :large do
    process resize_to_limit: [1600, nil]
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

end
