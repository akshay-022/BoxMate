When(/^I click on the "Destroy" button for the chef meal with id "(\d+)"$/) do |chef_meal_id|
  destroy_link_selector = "a[data-confirm='Are you sure?'][class='btn btn-danger col 2'][data-method='put'][href*='/chefinfos/2/destroy_entry?chefmealid=#{chef_meal_id}']"
  find(destroy_link_selector, match: :first).click
end