class CreateChefmeals < ActiveRecord::Migration
  def up
    create_table :chefmeals do |t|
      t.string :meal
      t.string :days
      t.integer :max_customers
      t.integer :num_customers
      t.string :username
      t.integer :chefinfo_id
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
