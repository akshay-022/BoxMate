# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chefmeals = [{:username => "aksh123", :meal => "Paneer Butter Masala", :days => "Monday" ,:max_customers => 3 ,:num_customers => 2, :chefinfo_id => 1},
		{:username => "aksh123", :meal => "Egg fry", :days => "Tuesday" ,:max_customers => 4 ,:num_customers => 2, :chefinfo_id => 1},
		{:username => "vasavi123", :meal => "Paneer Chilli", :days => "Monday" , :max_customers => 3 ,:num_customers => 2, :chefinfo_id => 2},
		{:username => "vasavi123", :meal => "French Toast", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 0, :chefinfo_id => 2},
		{:username => "maya123", :meal => "Noodles", :days => "Monday" , :max_customers => 3 ,:num_customers => 0, :chefinfo_id => 3},
		{:username => "maya123", :meal => "Manchurian", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 0, :chefinfo_id => 3},
		{:username => "tanisha123", :meal => "Pho", :days => "Monday" , :max_customers => 3 ,:num_customers => 0, :chefinfo_id => 4},
		{:username => "tanisha123", :meal => "Pho", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 0, :chefinfo_id => 4}
  	 ]

customermeals = [{:username => "omkar123", :chefmeal_id => 1, :customerinfo_id => 1},
		{:username => "omkar123", :chefmeal_id => 2, :customerinfo_id => 1},
		{:username => "akshat123",:chefmeal_id =>3, :customerinfo_id => 2},
		{:username => "akshat123",:chefmeal_id =>4, :customerinfo_id => 2},
		{:username => "abhinav123",:chefmeal_id => 5, :customerinfo_id => 3},
		{:username => "abhinav123",:chefmeal_id => 6, :customerinfo_id => 3}
	]

chefinfos = [{:name => 'Akshay', :username => "aksh123", :password => "password123",:food_constraint => 'vegetarian', :tags => 'indian,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Vasavi', :username => "vasavi123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Maya', :username => "maya123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'chinese,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Tanisha', :username => "tanisha123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'vietnamese,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"}
]


customerinfos = [{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"}
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