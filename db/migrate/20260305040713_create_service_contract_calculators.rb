class CreateServiceContractCalculators < ActiveRecord::Migration[8.0]
  def change
    create_table :service_contract_calculators do |t|
      t.integer :amount_in_cent, default: 0
      t.string :calculation_type, default: "brut-to-net"  
      t.integer :city_tax_rate_id
      t.integer :user_id

      t.timestamps
    end
  end
end
