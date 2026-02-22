class AddSlugToCredits < ActiveRecord::Migration[8.0]
  def change
    add_column :credits, :slug, :string, default: ""
  end
end
