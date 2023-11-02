class Chef < ActiveRecord::Base
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
      chef_here = Chef.find_by(name: name)
      if update_status==1
        chef_num_customers = chef_here.num_customers.split(",")
        chef_days = chef_here.days.split(",")
        our_index = chef_days.find_index(day)
        chef_num_customers[our_index] = (chef_num_customers[our_index].to_i + 1).to_s
        chef_here.num_customers = chef_num_customers*","
        return chef_here
      elsif update_status == -1
        chef_num_customers = chef_here.num_customers.split(",")
        chef_days = chef_here.days.split(",")
        our_index = chef_days.find_index(day)
        chef_num_customers[our_index] = (chef_num_customers[our_index].to_i - 1).to_s
        chef_here.num_customers = chef_num_customers*","
        return chef_here
      end
    end
end
  