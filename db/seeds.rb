# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'date'

chefmeals = [{:username => "aksh123", :meal => "Paneer Butter Masala", :days => Date.new(2023, 11, 15), :mealtime => "Lunch" ,:max_customers => 3 ,:num_customers => 1, :chefinfo_id => 1, :cuisine => 'indian'},
		{:username => "aksh123", :meal => "Egg fry", :days => Date.new(2023, 11, 16) , :mealtime => "Lunch" ,:max_customers => 4 ,:num_customers => 1, :chefinfo_id => 1, :cuisine => 'chinese'},
		{:username => "vasavi123", :meal => "Paneer Chilli", :days => Date.new(2023, 11, 15) , :mealtime => "Lunch" , :max_customers => 3 ,:num_customers => 1, :chefinfo_id => 2, :cuisine => 'vietnamese'},
		{:username => "vasavi123", :meal => "French Toast", :days => Date.new(2023, 11, 16) , :mealtime => "Lunch" , :max_customers => 4 ,:num_customers => 1, :chefinfo_id => 2, :cuisine => 'jain'},
		{:username => "maya123", :meal => "Noodles", :days => Date.new(2023, 11, 15) , :mealtime => "Lunch" , :max_customers => 3 ,:num_customers => 1, :chefinfo_id => 3, :cuisine => 'gluten-free'},
		{:username => "maya123", :meal => "Manchurian", :days => Date.new(2023, 11, 16) , :mealtime => "Lunch" , :max_customers => 4 ,:num_customers => 1, :chefinfo_id => 3, :cuisine => 'chinese'},
		{:username => "tanisha123", :meal => "Pho", :days => Date.new(2023, 11, 15) , :mealtime => "Lunch" , :max_customers => 3 ,:num_customers => 0, :chefinfo_id => 4, :cuisine => 'indian'},
		{:username => "tanisha123", :meal => "Pho", :days => Date.new(2023, 11, 16) , :mealtime => "Lunch" , :max_customers => 4 ,:num_customers => 0, :chefinfo_id => 4, :cuisine => 'jain'}
  	 ]

customermeals = [{:username => "omkar123", :chefmeal_id => 1, :customerinfo_id => 1, :num_meals => 1},
		{:username => "omkar123", :chefmeal_id => 2, :customerinfo_id => 1, :num_meals => 1},
		{:username => "akshat123",:chefmeal_id =>3, :customerinfo_id => 2, :num_meals => 1},
		{:username => "akshat123",:chefmeal_id =>4, :customerinfo_id => 2, :num_meals => 1},
		{:username => "abhinav123",:chefmeal_id => 5, :customerinfo_id => 3, :num_meals => 1},
		{:username => "abhinav123",:chefmeal_id => 6, :customerinfo_id => 3, :num_meals => 1}
	]

chefinfos = [{:name => 'Akshay', :username => "aksh123", :password => "password123",:food_constraint => 'vegetarian', :tags => 'indian,gluten-free', :description => "One of the authors of this SaaS app", :address => "127 st, New York", :address_coordinates => "50,40"},
			{:name => 'Vasavi', :username => "vasavi123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "825 st, New York", :address_coordinates => "30,80"},
			{:name => 'Maya', :username => "maya123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'chinese,gluten-free', :description => "One of the authors of this SaaS app", :address => "325 st, New York", :address_coordinates => "60,40"},
			{:name => 'Tanisha', :username => "tanisha123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'vietnamese,gluten-free', :description => "One of the authors of this SaaS app", :address => "225 st, New York", :address_coordinates => "30,40"}
]


customerinfos = [{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
				{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
				{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"}
]

chefmeals.each do |chef_meal_i|
  Chefmeal.create!(chef_meal_i)
end

chefinfos.each do |chef_info_i|
	Chefinfo.create!(chef_info_i)
end

customermeals.each do |customer_meal_i|
	Customermeal.create!(customer_meal_i)
end

customerinfos.each do |customer_info_i|
	Customerinfo.create!(customer_info_i)
end