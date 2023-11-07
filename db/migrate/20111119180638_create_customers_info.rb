class CreateCustomers_info < ActiveRecord::Migration
  def up
    create_table :customers_info do |t|
      t.string :name
      t.string :food_constraint #vegetarian/non-vegetarian/vegan/halal/kosher/eggetarian/jain
      t.string :tags
      t.text :description
      t.string :username
      t.string :password
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end


  
  def down
    drop_table :customers_info
  end
end
