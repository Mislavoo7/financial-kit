module CalculationHelper
  include MoneyRatioUtils # in libs

  def money_field(form, field, **opts)
    value = form.object.public_send(field)

    form.text_field field,
      {
        value: cents_to_euro(value) || 0,
        inputmode: "decimal",
        autocomplete: "off",
        placeholder: 0,
        pattern: "[0-9.,]+"
      }.merge(opts)
  end

  def ratio_field(form, field, **opts)
    value = form.object.public_send(field)

    form.text_field field,
      {
        value: ratio_to_percent(value) || 0,
        inputmode: "decimal",
        autocomplete: "off",
        pattern: "[0-9.,%]+",
        data: { ratio_field: true }
      }.merge(opts)
  end
end
