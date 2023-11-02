class CreateCustomers < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string :name
      t.string :food_constraint #vegetarian/non-vegetarian/vegan/halal/kosher/eggetarian/jain
      t.string :tags
      t.string :chefs
      t.string :needs #true if services needed on a specific day
      t.text :description
      t.string :username
      t.string :password
      t.string :days
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :customers
  end
end
