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
end
  