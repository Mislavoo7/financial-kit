module RatioNormalization
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_all_ratios
  end

  def normalize_all_ratios
    ratio_fields.each do |f|
      self[f] = normalize_ratio(self[f])
    end
  end
end
