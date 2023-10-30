class CreateChefs < ActiveRecord::Migration
  def up
    create_table :chefs do |t|
      t.string :name
      t.string :food_constraint #vegetarian/non-vegetarian/vegan/halal/kosher/eggetarian/jain
      t.string :tags, array: true, default: []
      t.string :schedule, array: true, default: []
      t.integer :max_people, array: true, default: []
      t.text :description
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :chefs
  end
end
