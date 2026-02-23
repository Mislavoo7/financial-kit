class CreateSalaryCalculators < ActiveRecord::Migration[8.0]
  def change
    create_table :salary_calculators do |t|
      t.integer :amount_in_cent, default: 0
      t.integer :personal_deduction, default: 1
      t.integer :kids_num, default: 0
      t.integer :dependents_num, default: 0
      t.string :disability, default: "no-disability"
      t.integer :city_tax_rate_id
      t.string :calculation_type, default: "brut-to-net"
      t.string :slug, default: ""
      t.integer :user_id

      t.timestamps
    end
  end
end
