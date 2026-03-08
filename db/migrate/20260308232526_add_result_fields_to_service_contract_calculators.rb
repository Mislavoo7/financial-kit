class AddResultFieldsToServiceContractCalculators < ActiveRecord::Migration[8.0]
  def change
    change_table :service_contract_calculators, bulk: true do |t|
      t.integer :brut_in_cent
      t.decimal :first_pillar_ratio, precision: 5, scale: 4
      t.integer :first_pillar_in_cent
      t.decimal :second_pillar_ratio, precision: 5, scale: 4
      t.integer :second_pillar_in_cent
      t.integer :total_pillar_in_cent
      t.decimal :income_tax_ratio, precision: 5, scale: 4
      t.integer :income_tax_in_cent
      t.integer :taxation_base_in_cent
      t.integer :net_in_cent
      t.decimal :health_insurance_ratio, precision: 5, scale: 4
      t.integer :health_insurance_in_cent
      t.integer :employer_to_pay_in_cent
    end
  end
end
