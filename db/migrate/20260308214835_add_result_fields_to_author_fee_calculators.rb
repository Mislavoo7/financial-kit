class AddResultFieldsToAuthorFeeCalculators < ActiveRecord::Migration[8.0]
  def change
    change_table :author_fee_calculators, bulk: true do |t|
      t.integer :brut_in_cent, default: 0, null: false

      t.decimal :lump_sum_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :lump_sum_in_cent, default: 0, null: false

      t.decimal :lump_sum_additional_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :lump_sum_additional_in_cent, default: 0, null: false

      t.integer :contribution_base_in_cent, default: 0, null: false

      t.decimal :first_pillar_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :first_pillar_in_cent, default: 0, null: false

      t.decimal :second_pillar_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :second_pillar_in_cent, default: 0, null: false

      t.integer :total_pillar_in_cent, default: 0, null: false

      t.decimal :income_tax_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :income_tax_in_cent, default: 0, null: false

      t.integer :taxation_base_in_cent, default: 0, null: false

      t.integer :income_in_cent, default: 0, null: false
      t.integer :net_in_cent, default: 0, null: false

      t.decimal :health_insurance_ratio, precision: 5, scale: 4, default: 0, null: false
      t.integer :health_insurance_in_cent, default: 0, null: false

      t.integer :employer_to_pay_in_cent, default: 0, null: false
    end
  end
end
