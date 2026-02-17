class CreateSeos < ActiveRecord::Migration[8.0]
  def change
    create_table :seos do |t|
      t.string :image
      t.string :seoable_type
      t.integer :seoable_id
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
