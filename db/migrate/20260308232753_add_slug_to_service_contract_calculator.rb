class AddSlugToServiceContractCalculator < ActiveRecord::Migration[8.0]
  def change
    add_column :service_contract_calculators, :slug, :string
  end
end
