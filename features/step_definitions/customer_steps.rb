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

Given(/^the following subscriptions exist in the database:$/) do |subscriptions|
  subscriptions.hashes.each do |subscription|
    Subscription.create subscription
  end
end

# === READ MAIN CUSTOMER PAGE ===
Given(/^I should see the following assignments:$/) do |scheduled_meals_table|
  actual_meals_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
  scheduled_meals_table.diff!(actual_meals_table)
end

# === DELETE MEAL - CUSTOMER PAGE ===
When(/^I click on the "Destroy one meal" button for the customer meal with id "(\d+)"$/) do |customer_meal_id|
  destroy_button_selector = "a[data-method='put'][href*='/customerinfos/1/destroy_entry?customermealid=#{customer_meal_id}']"
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

# === CHEF PROFILE - CUSTOMER PAGE ===
When(/^I click on the chef "(.*?)"$/) do |chef_name|
  chef_link_selector = "a[href*='/profiles/1']"
  first(chef_link_selector).click
end

# === CHEF SUBSCRIBE - CUSTOMER PAGE ===
And(/^I click the "Subscribe" button$/) do
  chef_subscribe_selector = "a:contains('Subscribe')"
  find(chef_subscribe_selector).click
end

# === CHEF REVIEW - CUSTOMER PAGE ===
And(/^I submit a review with "(.*?)" content and "(\d+)" rating$/) do |content, rating|
  fill_in 'chef_review_content', with: content
  fill_in 'chef_review_rating', with: rating
  click_button 'Submit Review'
end

Then (/page has "(.*?)" since all coordinates is the same/) do |content|
  expect(page).to have_content(content)
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
  # expect(page).to have_content(content)
  expect(page).to have_no_content(content)
end