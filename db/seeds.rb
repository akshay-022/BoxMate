# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chefs = [{:name => 'Akshay', :username => "aksh123", :schedule => "Paneer Butter Masala", :days => "Monday" ,:max_customers => 3 ,:num_customers => 3},
		{:name => 'Akshay', :username => "aksh123", :schedule => "Egg fry", :days => "Tuesday" ,:max_customers => 4 ,:num_customers => 3},
		{:name => 'Vasavi', :username => "vasavi123", :schedule => "Paneer Chilli", :days => "Monday" , :max_customers => 3 ,:num_customers => 1},
		{:name => 'Vasavi', :username => "vasavi123", :schedule => "French Toast", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 2},
		{:name => 'Maya', :username => "maya123", :schedule => "Noodles", :days => "Monday" , :max_customers => 3 ,:num_customers => 1},
		{:name => 'Maya', :username => "maya123", :schedule => "Manchurian", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 1},
		{:name => 'Tanisha', :username => "tanisha123", :schedule => "Pho", :days => "Monday" , :max_customers => 3 ,:num_customers => 2},
		{:name => 'Tanisha', :username => "tanisha123", :schedule => "Pho", :days => "Tuesday" , :max_customers => 4 ,:num_customers => 4},
  	 ]

customers = [{:name => 'Omkar', :username => "omkar123", :days => "Monday" ,:chefs => "Akshay"},
		{:name => 'Omkar', :username => "omkar123", :days => "Tuesday" ,:chefs => "Vasavi"},
		{:name => 'Akshat', :username => "akshat123", :days => "Monday" ,:chefs =>"Vasavi"},
		{:name => 'Akshat', :username => "akshat123", :days => "Tuesday" ,:chefs =>"Vasavi"},
		{:name => 'Abhinav', :username => "abhinav123", :days => "Monday" ,:chefs => "Tanisha"},
		{:name => 'Abhinav', :username => "abhinav123", :days => "Tuesday" ,:chefs => "Maya"},
	]

chefs_info = [{:name => 'Akshay', :username => "aksh123", :password => "password123",:food_constraint => 'vegetarian', :tags => 'indian,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Vasavi', :username => "vasavi123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Maya', :username => "maya123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'chinese,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
			{:name => 'Tanisha', :username => "tanisha123", :password => "password123", :food_constraint => 'non-vegetarian', :tags => 'vietnamese,gluten-free', :description => "One of the authors of this SaaS app", :address => "125 st, New York", :address_coordinates => "30,40"},
]


customers_info = [{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Omkar', :username => "omkar123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Akshat', :username => "akshat123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
				{:name => 'Abhinav', :username => "abhinav123", :password => "password123", :food_constraint => 'vegetarian', :tags => 'indian,jain', :description => "One of the authors of this SaaS app"},
]

chefs.each do |chef|
  Chef.create!(chef)
end

chefs_info.each do |chef_info|
	Chef_info.create!(chef_info)
end

customers.each do |customer|
	Customer.create!(customer)
end

customers_info.each do |customer_info|
	Customer_info.create!(customer_info)
end