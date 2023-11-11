class Customerinfo < ActiveRecord::Base

    has_many :customermeals, :dependent => :destroy
    
    def self.get_customer_meal_details(customerinfo)
        @customers = customerinfo.customermeals
        @days = []
        @chefs = []
        @meals = []
        @mealtimes = []
        @customers.each do |customer|
          @days.append(customer.chefmeal.days.to_s)
          @chefs.append(customer.chefmeal.chefinfo.name)
          @meals.append(customer.chefmeal.meal)
          @mealtimes.append(customer.chefmeal.mealtime)
        end
        return @days, @mealtimes, @chefs, @meals
      end
end
