class CreateCustomermeals < ActiveRecord::Migration
  def up
    create_table :customermeals do |t|
      t.integer :customerinfo_id
      t.integer :chefmeal_id
      t.string :username
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.references :customerinfo
      t.references :chefmeal
      t.timestamps
    end 
  end



  def down
    drop_table :customermeals
  end
end
