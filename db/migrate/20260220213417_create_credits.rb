class CreateCredits < ActiveRecord::Migration[8.0]
  def change
    create_table :credits do |t|
      t.string  :calculation_method, default: "equal-installments"
      t.integer :amount_in_cent, default: 0
      t.decimal :interest_ratio, precision: 5, scale: 4, default: 0.0
      t.integer :repayment_year, default: 0
      t.integer :months_one, default: 0
      t.integer :start, default: 0
      t.integer :number_of_installments
      t.integer :time_horizon
      t.integer :user_id
      t.date    :start_at
      t.timestamps
    end
  end
end
