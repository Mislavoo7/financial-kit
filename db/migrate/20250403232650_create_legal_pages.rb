class CreateLegalPages < ActiveRecord::Migration[8.0]
  def change
    create_table :legal_pages do |t|
      t.boolean :is_visible, default: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
