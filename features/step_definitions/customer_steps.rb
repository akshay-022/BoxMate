Given(/^the following customers exist in the database:$/) do |customers_table|
    customers_table.hashes.each do |customer|
        Customer.create customer
    end
end

Given(/^I am a customer with username "(.*?)"$/) do |username|
    @customer = Customer.find_by(username: username)
end

Then(/^I should see the following schedule:$/) do |assignments_table|
    actual_assignments_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
    assignments_table.diff!(actual_assignments_table)
end

Given(/^I have the following schedule:$/) do |scheduled_meals_table|
    actual_meals_table = find('#movies').all('tr').map { |row| row.all('th, td').map(&:text) }
    scheduled_meals_table.diff!(actual_meals_table)
end
  
When(/^I remove the day "(.*?)" from the schedule of customer$/) do |day|
    step "I fill in \"new_entry[day]\" with \"#{day}\""
    step "I press \"Destroy Chef Entry\""
end

Then(/^the chef "(.*?)" should be removed from my schedule$/) do |chef|
    expect(page).not_to have_content(chef)
end

When(/^I add the following meals to my schedule:$/) do |meals_table|
    meals_table.hashes.each do |meal|
        step "I fill in \"new_entry[day]\" with \"#{meal['Day']}\""
        step "I fill in \"new_entry[chef]\" with \"#{meal['Chef']}\""
        step "I press \"Update customer Info\""
    end
end

Then(/^my meal schedule should be updated$/) do
    expect(page).to have_content("Your choice was successfully updated!")
end