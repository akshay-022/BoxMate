require 'date'

class CreateChefmeals < ActiveRecord::Migration
  def up
    create_table :chefmeals do |t|
      t.string :meal
      t.date :days
      t.string :mealtime
      t.integer :max_customers
      t.integer :num_customers
      t.string :username
      t.integer :chefinfo_id
      t.string :cuisine
      t.references :chefinfo
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :chefmeals
  end
end
