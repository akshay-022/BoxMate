class CreateCustomers < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string :name
      t.string :chefs
      t.string :username
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
