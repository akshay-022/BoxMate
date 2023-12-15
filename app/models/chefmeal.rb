class Chefmeal < ActiveRecord::Base

  belongs_to :chefinfo
  has_many :customermeals, :dependent => :destroy

    def self.update_num_customers(name, day, update_status) #Assuming every chef cooks only one dish on one day. We will finally make the days dates and not days of the week.
      chef_here = Chefinfo.find_by(name: name)
      if update_status==1
        chef_meal = chef_here.chefmeals.find_by(days: day)
        chef_meal.num_customers = (chef_meal.num_customers.to_i + 1)
        chef_meal.save
      end
      return chef_meal.num_customers
    end

    def self.get_customers_per_chefmeal_via_username(chefmeal)
      all_customers_per_chef = Customermeal.where(:chefmeal_id => chefmeal.id)
      all_customers = []
      all_customers_per_chef.each do |every_customer|
        all_customers.append(every_customer.username)        
      end
      return all_customers
    end

    def self.with_cuisines(cuisines_list)
       where(cuisine: cuisines_list)
    end


    def self.get_distance(address_coordinates, customer_username)
      customer = Customerinfo.find_by(username: customer_username)
      address_coordinates2 = customer.address_coordinates
      coord1 = address_coordinates.split(",").map(&:to_f)
      coord2 = address_coordinates2.split(",").map(&:to_f)
      # Calculate the squared differences between corresponding coordinates
      squared_differences = coord1.zip(coord2).map { |a, b| (a - b)**2 }
      # Calculate the square root of the sum of squared differences
      distance = Math.sqrt(squared_differences.sum)
      return distance
    end
end
  