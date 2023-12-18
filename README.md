Hello and welcome to the second product iteration of BoxMate!!

# PLEASE CHECK THE final-submission BRANCH of the repo!!

This is the team behind this product:
1. Akshay Iyer agi2108
2. Nagavasavi Jeepalyam nj2506
3. Tanisha Bisht tb3061
4. Maya Srikanth - ms6198

You can login to our app using your username and password, and we will automatically detect if you are a chef or customer.
You can check out our sample usernames and passwords in seed.rb. 

Use the below login's to do so:

Customers-
1. username : omkar123, password : password123
2. username : akshat123, password : password123
3. username : abhinav123, password : abhinav123

Chefs-
1. username : aksh123, password : password123
2. username : vasavi123, password : password123
3. username : tanisha123, password : password123
4. username : maya123, password : password123


# Iter 1 : 

During the login -
1. Try inputting the wrong username, and then a correct username and the wrong password. See the notices flashed.

First login with the chef's (aksh123 maybe) credentials, and see the information we display for the chef. We display the day, meal the chef has to cook, the max number of customers they agreed to cook for on that day, and the number of customers assigned to the chef upto now.
1. Change your schedule by clicking on the button, and add a new meal on a particular day, with the number of people you can cook for.
2. Delete an entry because something last minute came up in your schedule, and see how our interface let's you do that.
3. Note the current number of customers and meal for a particular day.

Login with the customer's credentials now (omkar123 maybe).
1. Try removing an entry from Akshay (aksh123 username chef). Remember this for a later step.
2. Try adding an entry for a different chef.

Now, login again as aksh123, and observe that the number of customers on the day you edited in point 2 of the customer actions, have changed according to the customer's actions.
Play around a bit more if you want, maybe try some other chefs and customers and see how it updates!

# Iter 2 added features : 
1. We have added sign up pages
2. We have added log out buttons
3. We are now checking all number field entries and ensuring a number is entered. (customer entry validation)
4. No one can access any other url now, unless they enter through the login page. (session handling)
5. We have modified our underlying database, because it had many redundancies and unoptimalities in iter 1. We are now using foreign keys and rails associations.
6. We have switched the days entry to date formats, and changed the way it is selected (calendar dropdown now). Thus we can make entries for more than a single week now.
7. We have added multiple meal types for every day, i.e. Breakfast, lunch, snacks and dinner.
8. We have added chef functionality, where they can click on their schedule row, and see all the customers assigned to them.
9. We have added sorting of chefs by name, dates, mealtime, meal and cuisine type.
10. We have added filtering of chefs by their tags and preferences. 
11. All redundant entries and deletions are now by buttons in the corresponding rows, and not user entries.
12. We have added subscriptions functionality now. Chefs can add a meal recurrence, and 5 meals of those intervals will get automatically added. We will integrate this functionality with customer subscriptions in the next iteration.

# Final Submissions added features : 
1. We have created the complete subscriptions model. Users can now subscribe to chefs, to automatically get added to all their meals. 
   If the chef adds new meals, those meals get automatically added to subscribed customers too.
2. We have added reviews to chefs. Customes can now write detailed reviews for chefs and give them a rating from 1-5.
3. We now have a dedicated Profiles page for every chef. This page has all the chef details and all their meals. You can subscribe to a chef's meals from this page too.
   You can also see the average rating and all past reviews of the chef.
4. The same customer can add multiple meals on the same day and time by a chef now. 
   All columns now have a number of meals table, which shows how many orders the customer has placed with the chef for a particular meal.
5. We now use the address coordinates of chefs and customers to display a distance metric that shows how far the chef is from you.
6. We added multiple table and column entries into our database, including ones for subscription tracking and reviews.


Note : "/" is the root directory, which is the sign in page. Going to "/" will always redirect you to "/signIn".
        To logout and login as a different chef/customer, click the logout button in the top right corner and login again differently.


# Running and testing

Github link : https://github.com/akshay-022/BoxMate/tree/proj-iter2
Heroku link : https://whispering-brook-51278-37b54226ab0d.herokuapp.com/

Steps to run the Rspectests:
- git clone git@github.com:akshay-022/BoxMate.git
- cd BoxMate
- git checkout final-submission
- bundle install
- bundle exec rake db:drop
- bundle exec rake db:create
- bundle exec rake db:migrate
- bundle exec rake db:test:prepare
- bundle exec rake db:seed
- bundle exec rspec

Steps to run Cucumber Features:
- bundle exec rake db:drop RAILS_ENV=test
- bundle exec rake db:migrate RAILS_ENV=test
- bundle exec rake cucumber


# Test additions for iter 2

1. Iter-1 had 6 scenarios. Iter-2 has 15 scenarios.
2. We have added rspec tests for all the code we added, with a total coverage of 100% now.

# Test additions for final submission

1. We have updated rspec tests for all the code we added, with a total coverage of 100% now.
2. Final-iter has 20 scenarios with 192 steps passed
3. Scenarios added for each of the new features added:
   - Subscription Testing: Ensuring that customers can successfully subscribe to a chef.
   - Customer Review Feature: Verifying the functionality allowing customers to review chefs.
   - Chef Profile Page: Testing the presence and functionality of individual profile pages for chefs.
   - Distance Calculation in Schedule: Confirming that customers can view the correct distance information in the schedule table based on the chef's location.
   - Subscription Database Addition: Ensuring the proper integration of the subscription feature with the database.
   - Meal Addition Modification: Modifying existing tests to accommodate the scenario where customers can add multiple meals on the same day.
