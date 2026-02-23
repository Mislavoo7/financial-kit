class CreateCityTaxRates < ActiveRecord::Migration[8.0]
  def change
    create_table :city_tax_rates do |t|
      t.string :title
      t.decimal :lower_rate, precision: 5, scale: 4
      t.decimal :higher_rate, precision: 5, scale: 4

      t.timestamps
    end
  end
end
