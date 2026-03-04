class AddCalculationFieldsToSalaryCalculators < ActiveRecord::Migration[8.0]
  def change
    change_table :salary_calculators, bulk: true do |t|
      t.integer :brut_in_cent, default: 0, null: false
      t.integer :first_pillar_in_cent, default: 0, null: false
      t.integer :second_pillar_in_cent, default: 0, null: false
      t.integer :total_pillar_in_cent, default: 0, null: false
      t.integer :taxation_base_in_cent, default: 0, null: false
      t.integer :pdv_one_in_cent, default: 0, null: false
      t.integer :pdv_two_in_cent, default: 0, null: false
      t.integer :income_tax_in_cent, default: 0, null: false
      t.integer :health_insurance_in_cent, default: 0, null: false
      t.integer :employer_to_pay_in_cent, default: 0, null: false
      t.integer :net_in_cent, default: 0, null: false

      t.decimal :first_pillar_ratio,      precision: 5, scale: 4, default: 0, null: false
      t.decimal :second_pillar_ratio,     precision: 5, scale: 4, default: 0, null: false
      t.decimal :total_pillar_ratio,      precision: 5, scale: 4, default: 0, null: false
      t.decimal :pdv_one_ratio,           precision: 5, scale: 4, default: 0, null: false
      t.decimal :pdv_two_ratio,           precision: 5, scale: 4, default: 0, null: false
      t.decimal :health_insurance_ratio,  precision: 5, scale: 4, default: 0, null: false
    end
  end
end
