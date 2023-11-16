Hello and welcome to the second product iteration of BoxMate!!

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

Note : "/" is the root directory, which is the sign in page. Going to "/" will always redirect you to "/signIn".
        To logout and login as a different chef/customer, click the logout button in the top right corner and login again differently.


# Running and testing

Github link : https://github.com/akshay-022/BoxMate
Heroku link : https://whispering-brook-51278-37b54226ab0d.herokuapp.com/

Steps to run the Rspectests:
- git clone git@github.com:akshay-022/BoxMate.git
- cd BoxMate
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
- bundle exec rake db:seed RAILS_ENV=test
- bundle exec rake cucumber
