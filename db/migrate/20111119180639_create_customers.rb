class CreateCustomers < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string :name
      t.string :food_constraint #vegetarian/non-vegetarian/vegan/halal/kosher/eggetarian/jain
      t.string :tags, array: true, default: []
      t.string :chefs, array: true, default: []
      t.boolean :needs, array: true, default: [] #true if services needed on a specific day
      t.text :description
      t.string :username
      t.string :password
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :customers
  end
end
