class Customer < ActiveRecord::Base
    def self.find_dishes(days, chefs)
        meals = []
        for i in 1..days.length() do
            day = days[i-1]
            chef = chefs[i-1]
            our_chef = Chef.find_by(name: chef.capitalize())
            days_chef = our_chef.days.split(",")
            meals_chef = our_chef.schedule.split(",")
            chef_dish_index = days_chef.find_index(day)
            our_meal = meals_chef[chef_dish_index]
            meals.append(our_meal)
        end
        return meals
    end
    def self.all_cuisines
        #tags_arrays = Chef.distinct.pluck(:tags).map { |tags| JSON.parse(tags) }
        #unique_tags = tags_arrays.flatten.uniq
        return ["indian", "jain", "chinese", "vietnamese", "gluten-free"]
    end
end
