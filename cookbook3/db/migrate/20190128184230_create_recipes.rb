class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.text :instructions
      t.references :category
      t.timestamps
    end
  end
end
