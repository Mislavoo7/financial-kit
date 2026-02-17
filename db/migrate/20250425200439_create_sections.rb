class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.string :section_type, default: "simple"
      t.string :sectionable_type
      t.integer :sectionable_id
      t.boolean :is_visible, default: true
      t.integer :position, default: 1000

      t.timestamps
    end
  end
end
