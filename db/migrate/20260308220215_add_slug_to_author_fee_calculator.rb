class AddSlugToAuthorFeeCalculator < ActiveRecord::Migration[8.0]
  def change
    add_column :author_fee_calculators, :slug, :string
  end
end
