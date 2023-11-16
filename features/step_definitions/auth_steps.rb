# Step Definition for Background: Seed Database with Chef Information
Given(/^the following chefs exist in the database:$/) do |chefs_table|
  chefs_table.hashes.each do |chef|
    Chefinfo.create chef
  end
end

# Step Definition for Background: Seed Database with Customer Information
Given(/^the following customers exist in the database:$/) do |customers_table|
  customers_table.hashes.each do |customer|
    Customerinfo.create customer
  end
end

# === FEATURE - CUSTOMER SIGN UP ===
When(/^I fill in the customer signup form with valid details$/) do |customer_info_table|
  customer_info = customer_info_table.rows_hash
  fill_in 'common[username]', with: customer_info['username']
  fill_in 'common[password]', with: customer_info['password']
  fill_in 'common[name]', with: customer_info['name']
  fill_in 'common[food_constraint]', with: customer_info['food_constraint']
  fill_in 'common[tags]', with: customer_info['tags']
  fill_in 'common[description]', with: customer_info['description']
  fill_in 'common[address_coordinates_x]', with: customer_info['address_coordinates_x']
  fill_in 'common[address_coordinates_y]', with: customer_info['address_coordinates_y']
end

When(/^I submit the signup form$/) do
  click_button 'Sign Up'
end

Then(/^I should see a success message$/) do
  expect(page).to have_content('Your profile was successfully created!!')
end

Then(/^I should be redirected to the login page$/) do
  commons_path
end

# === FEATURE - CHEF SIGN UP ===
When(/^I fill in the chef signup form with valid details$/) do |chef_info_table|
  chef_info = chef_info_table.rows_hash
  fill_in 'common[username]', with: chef_info['username']
  fill_in 'common[password]', with: chef_info['password']
  fill_in 'common[name]', with: chef_info['name']
  fill_in 'common[food_constraint]', with: chef_info['food_constraint']
  fill_in 'common[tags]', with: chef_info['tags']
  fill_in 'common[description]', with: chef_info['description']
  fill_in 'common[address_coordinates_x]', with: chef_info['address_coordinates_x']
  fill_in 'common[address_coordinates_y]', with: chef_info['address_coordinates_y']
end

# === FEATURE - CUSTOMER LOGIN - CORRECT ===
When(/^I fill in the customer login form with:$/) do |customer_credentials_table|
  customer_credentials = customer_credentials_table.rows_hash
  fill_in 'common[username]', with: customer_credentials['username']
  fill_in 'common[password]', with: customer_credentials['password']
end

When(/^I submit the login form$/) do
  click_button 'Login'
end

# === FEATURE - CHEF LOGIN - CORRECT ===
When(/^I fill in the chef login form with:$/) do |chef_credentials_table|
  chef_credentials = chef_credentials_table.rows_hash
  fill_in 'common[username]', with: chef_credentials['username']
  fill_in 'common[password]', with: chef_credentials['password']
end

# === FEATURE - CHEF LOGIN - INCORRECT PASSWORD === 
Then(/^I should see an error message for password$/) do
  expect(page).to have_content('Invalid password')
end

Then(/^I should see an error message for username$/) do
  expect(page).to have_content('Invalid username')
end

Then(/^I should remain on the login page$/) do
  commons_path
end