class AddNumMealsToCustomermeals < ActiveRecord::Migration
  def change
    add_column :customermeals, :num_meals, :integer
  end
end
