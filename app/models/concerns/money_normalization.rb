module MoneyNormalization
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_all_money
  end

  def normalize_all_money
    money_fields.each do |field|
      next unless will_save_change_to_attribute?(field)

      val = self[field]
      self[field] = normalize_money_euro(val) unless val.blank?
    end
  end

  def normalize_money_euro(val)
    return nil if val.blank?

    v = BigDecimal(val.to_s.tr(",", "."))
    (v * 100).round
  end
end
