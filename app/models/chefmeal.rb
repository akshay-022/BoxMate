class Chefmeal < ActiveRecord::Base

  belongs_to :chefinfo
  has_many :customermeals, :dependent => :destroy

    def self.get_chefs_meals
      final_table = []
      all_chefs = Chef.all
      all_chefs.each do |chef|
        all_days = chef.days.split(",")
        all_meals = chef.schedule.split(",")
        for i in 1..all_days.length()
          final_table.append({:name => chef.name, :meal => all_meals[i-1], :day=> all_days[i-1]})
        end
      end
      return final_table
    end


    def self.update_num_customers(name, day, update_status) #Assuming every chef cooks only one dish on one day. We will finally make the days dates and not days of the week.
      chef_here = Chefinfo.find_by(name: name)
      if update_status==1
        chef_meal = chef_here.chefmeals.find_by(days: day)
        chef_meal.num_customers = (chef_meal.num_customers.to_i + 1)
        chef_meal.save
      elsif update_status == -1
        chef_meal = chef_here.chefmeals.find_by(days: day)
        chef_meal.num_customers = (chef_meal.num_customers.to_i - 1)
        chef_meal.save
      end
    end

    def self.get_customers_per_chefmeal(chefmeal)
      all_customers_per_chef = Customermeal.where(:chefmeal_id => chefmeal.id)
      all_customers = []
      all_customers_per_chef.each do |every_customer|
        all_customers.append(every_customer.customerinfo_id)        
      end
      return all_customers
    end

    def self.get_customers_per_chefmeal_via_username(chefmeal)
      all_customers_per_chef = Customermeal.where(:chefmeal_id => chefmeal.id)
      all_customers = []
      all_customers_per_chef.each do |every_customer|
        all_customers.append(every_customer.username)        
      end
      return all_customers
    end
end
  