class CreatePages < ActiveRecord::Migration[8.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :image
      t.boolean :is_visible, default: true
      t.integer :position, default: 1000

      t.timestamps
    end
  end
end
