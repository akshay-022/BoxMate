# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chefs = [{:name => 'Akshay', :username => "aksh123", :password => "password123",:food_constraint => 'vegetarian', :tags => ['indian', 'gluten-free'], :schedule => ["Paneer Butter Masala", "Egg fry"], :max_people => [3, 4], :description => "One of the authors of this SaaS app"},
		{:name => 'Vasavi', :username => "vasavi123", :password => "password123", :food_constraint => 'vegetarian', :tags => ['indian', 'jain'], :schedule => ["Paneer Chilli", "French Toast"], :max_people => [3, 4], :description => "One of the authors of this SaaS app"},
		{:name => 'Maya', :username => "maya123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => ['chinese', 'gluten-free'], :schedule => ["Noodles", "Manchurian"], :max_people => [3, 4], :description => "One of the authors of this SaaS app"},
		{:name => 'Tanisha', :username => "tanisha123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => ['vietnamese', 'gluten-free'], :schedule => ["Pho", "Pho"], :max_people => [3, 4], :description => "One of the authors of this SaaS app"},
  	 ]

customers = [{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => ['indian', 'jain'], :chefs => ["Akshay", ""], :needs => [true, false], :description => "One of the authors of this SaaS app"},
		{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => ['indian', 'jain'], :chefs => ["", "Vasavi"], :needs => [true, true], :description => "One of the authors of this SaaS app"},
		{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => ['indian', 'jain'], :chefs => ["Tanisha", "Maya"], :needs => [true, true], :description => "One of the authors of this SaaS app"},
	]

	
chefs.each do |chef|
  Chef.create!(chef)
end

customers.each do |customer|
	Customer.create!(customer)
  end