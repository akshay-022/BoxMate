class CreateChefs < ActiveRecord::Migration
  def up
    create_table :chefs do |t|
      t.string :name
      t.string :schedule
      t.string :days
      t.string :max_customers
      t.string :num_customers
      t.string :username
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :chefs
  end
end
