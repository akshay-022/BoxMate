Hello and welcome to the first product iteration of BoxMate!!

This is the team behind this product:
Akshay Iyer agi2108
Nagavasavi Jeepalyam nj2506
Tanisha Bisht tb3061
Maya Srikanth - ms6198

You can login to our app using your username and password, and we will automatically detect if you are a chef or customer.
You can check out our sample usernames and passwords in seed.rb. 

Use the below login's to do so:

Customer-
username : omkar123
password : password123

Chef-
username : aksh123
password : password123

Iter 1 : 

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

Iter 2 added features : 
1. We have added sign up pages
2. We have added log out buttons
3. We are now checking all number field entries and ensuring a number is entered. (customer entry validation)
4. No one can access any other url now, unless they enter through the login page.
5. We have modified our underlying database, because it had many redundancies and unoptimalities in iter 1. We are now using foreign keys and rails associations.
6. We have switched the days entry to date formats, and changed the way it is selected (calendar dropdown now). Thus we can make entries for more than a single week now.
7. We have added multiple meal types for every day, i.e. Breakfast, lunch, snacks and dinner.
8. We have added chef functionality, where they can click on their schedule row, and see all the customers assigned to them.
9. We have added sorting of chefs by name, dates, mealtime, meal and cuisine type.
10. We have added filtering of chefs by their tags and preferences. 
11. All redundant entries and deletions are now by buttons in the corresponding rows, and not user entries.
12. We have added subscriptions functionality now. Chefs can add a meal recurrence, as to how frequently they will cook so that they do not need to manually add entries for every day/week.
    Customers can subscribe to these recurrences in our next iteration.


Customers : 


Note : "/" is the root directory, which is the sign in page. Going to "/" will always redirect you to "/signIn".
        To login and logout as a different chef/customer, go back to "/" in the url and login again differently.

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
