class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :recipe_type
      t.string :cuisine
      t.integer :difficulty, default: 0
      t.integer :cook_time

      t.timestamps
    end
  end
end
