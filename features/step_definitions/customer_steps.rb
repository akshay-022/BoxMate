# === FILL IN DATABASE ===
Given(/^the following chef meals exist in the database:$/) do |chef_meals|
  chef_meals.hashes.each do |chef_meal|
    Chefmeal.create chef_meal
  end
end

Given(/^the following customer meals exist in the database:$/) do |customer_meals|
  customer_meals.hashes.each do |customer_meal|
    Customermeal.create customer_meal
  end
end

# === READ MAIN CUSTOMER PAGE ===
Given(/^I should see the following assignments:$/) do |scheduled_meals_table|
  actual_meals_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
  scheduled_meals_table.diff!(actual_meals_table)
end

# === DELETE MEAL - CUSTOMER PAGE ===
When(/^I click on the "Destroy" button for the customer meal with id "(\d+)"$/) do |customer_meal_id|
  destroy_button_selector = "a[data-method='put'][href*='/destroy_entry?customermealid=#{customer_meal_id}']"
  find(destroy_button_selector).click
end

When(/^I accept the alert$/) do
  if page.driver.browser.respond_to?(:switch_to) && page.driver.browser.switch_to.alert
    page.driver.browser.switch_to.alert.accept
  end
end

# === ADD MEAL - CUSTOMER PAGE ===
When(/^I click the "Add to meals" button for the chef meal with id "(\d+)"$/) do |chefmeal_id|
  link_selector = "a[data-method='put'][href*='/customerinfos/1/update?chefmealid=#{chefmeal_id}']"
  find(link_selector).click
end

# === LOGOUT ===
When(/^I click "(.*)" button$/) do |content|
  click_link content
end

# === COMMON ===
Then (/page contains "(.*)"/) do |content|
  expect(page).to have_content(content)
end
Then (/page does not contain "(.*)"/) do |content|
  expect(page).to have_content(content)
  # expect(page).to have_no_content(content)
end