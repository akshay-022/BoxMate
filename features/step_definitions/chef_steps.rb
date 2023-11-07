Given(/^the following chefs exist in the database:$/) do |chefs_table|
  chefs_table.hashes.each do |chef|
    Chef.create chef
  end
end

Given(/^I am a chef with username "(.*?)"$/) do |username|
  @chef = Chef.find_by(username: username)
end

When(/^I schedule the following meals for the week:$/) do |meals_table|
  meals_table.hashes.each do |meal|
    step "I fill in \"new_entry[day]\" with \"#{meal['Day']}\""
    step "I fill in \"new_entry[schedule]\" with \"#{meal['Meal']}\""
    step "I fill in \"new_entry[max_customers]\" with \"#{meal['Max Customers']}\""
    step "I press \"Update Chef Info\""
  end
end

Then(/^my weekly meal schedule should be complete$/) do
  expect(page).to have_content("Your info was successfully updated!")
end

Then(/^I should see the following assignments:$/) do |assignments_table|
  actual_assignments_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
  assignments_table.diff!(actual_assignments_table)
end

Given(/^I have the following scheduled meals:$/) do |scheduled_meals_table|
  actual_meals_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
  scheduled_meals_table.diff!(actual_meals_table)
end

When(/^I remove the day "(.*?)" from the schedule$/) do |day|
  step "I fill in \"new_entry[day]\" with \"#{day}\""
  step "I press \"Destroy Chef Entry\""
end

Then(/^the meal "(.*?)" should be removed from my schedule$/) do |meal|
  expect(page).not_to have_content(meal)
end
