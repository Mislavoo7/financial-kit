module CalculationMethods
  extend ActiveSupport::Concern

  CALCULATION_TYPES = [ "brut-to-net", "net-to-brut" ].freeze
  included do
    validates :calculation_type,
      presence: true,
      inclusion: { in: CALCULATION_TYPES },
      if: -> { has_attribute?(:calculation_type) }
  end

  def humanize_euro(euro)
    formatted = sprintf("%.2f", euro)
    integer_part, decimal_part = formatted.split(".")
    integer_part_with_dots = integer_part.gsub(/(\d)(?=(\d{3})+\z)/, '\1.')
    "#{integer_part_with_dots},#{decimal_part} €"
  end

  def cents_to_euro(cents)
    return "" if cents.blank?
    cents.to_f / 100
  end

  def euro_to_cent(euro)
    (euro.to_f * 100).round
  end

  def ratio_to_percent(ratio)
    return "" if ratio.blank?
    "#{(ratio.to_f * 100).round(4).to_s.sub(/\.0+$/, "").sub(/(\.\d*[1-9])0+$/, '\1')}%"
  end

  def normalize_ratio(val)
    return nil if val.blank?
    v = BigDecimal(val.to_s.tr(",", ".").delete("%").strip)
    v > 1 ? (v / 100) : v
  end
end
