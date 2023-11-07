class CreateChefs_info < ActiveRecord::Migration
  def up
    create_table :chefs_info do |t|
      t.string :name
      t.string :food_constraint #vegetarian/non-vegetarian/vegan/halal/kosher/eggetarian/jain
      t.string :tags
      t.text :description
      t.string :address
      t.string :address_coordinates
      t.string :username
      t.string :password
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :chefs_info
  end
end
