class Customerinfo < ActiveRecord::Base

    has_many :customermeals, dependent: :delete_all
    
    def self.get_customer_meal_details(customerinfo)
        @customers = customerinfo.customermeals
        @days = []
        @chefs = []
        @meals = []
        @customers.each do |customer|
          @days.append(customer.chefmeal.days)
          @chefs.append(customer.chefmeal.chefinfo.name)
          @meals.append(customer.chefmeal.meal)
        end
        return @days, @chefs, @meals
      end
end
