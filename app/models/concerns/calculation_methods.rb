module CalculationMethods
  def humanize_euro(value)
    num = number_with_precision(
      value.to_d,
      precision: 2,
      delimiter: ".",
      separator: ","
    )

    return "#{num} €"
  end
  
  def cents_to_euro(cents)
    return "" if cents.blank?
    sprintf("%.2f", cents.to_f / 100)
  end

  def euro_to_cent(euro)
    return euro.to_i * 100.0
  end

  def ratio_to_percent(ratio)
    return "" if ratio.blank?
    "#{(ratio.to_f * 100).round(4).to_s.sub(/\.0+$/, "").sub(/(\.\d*[1-9])0+$/, '\1')}%"
  end

  def normalize_ratio(val)
    return nil if val.blank?
    v = BigDecimal(val.to_s.tr(",", "."))
    v > 1 ? (v / 100) : v
  end
end
