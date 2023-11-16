class Customerinfo < ActiveRecord::Base

    has_many :customermeals, :dependent => :destroy
    
    def self.get_customer_meal_details(customerinfo)
        @customers = customerinfo.customermeals
        @days = []
        @chefs = []
        @meals = []
        @mealtimes = []
        @customermeal_ids = []
        @customers.each do |customer|
          if customer.chefmeal.blank?
          else
            @days.append(customer.chefmeal.days.to_s)
            @chefs.append(customer.chefmeal.chefinfo.name)
            @meals.append(customer.chefmeal.meal)
            @mealtimes.append(customer.chefmeal.mealtime)
            @customermeal_ids.append(customer.id)
          end
        end
        return @days, @mealtimes, @chefs, @meals, @customermeal_ids
      end
end
