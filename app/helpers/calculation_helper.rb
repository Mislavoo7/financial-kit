module CalculationHelper
  include CalculationMethods

  def money_field(form, field, **opts)
    value = form.object.send(field)

    form.text_field field,
      {
        value: cents_to_euro(value) || 0,
        inputmode: "decimal",
        autocomplete: "off",
        placeholder: 0,
        pattern: "[0-9.,]+",
        #        data: { money_field: true }
      }.merge(opts)
  end

  def ratio_field(form, field, **opts)
    value = form.object.send(field)

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
