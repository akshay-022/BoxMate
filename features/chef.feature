Feature: Chef's Weekly Schedule and Meal Assignment

  As a chef
  So that I can plan my week effectively
  I want to schedule meals for each day, specifying the type of meal, and the number of people to cook for.

Background: Chef Database
  Given the following chefs exist in the database:
    | name     | username     | password      | food_constraint | tags                     | schedule                     | days                   | max_customers     | num_customers    | description                              | address               | address_coordinates |
    | Akshay   | aksh123      | password123   | vegetarian      | indian,gluten-free       | Paneer Butter Masala,Egg fry | Monday,Tuesday         | 3,4               | 3,3              | One of the authors of this SaaS app      | 125 st, New York      | 30,40               |
    | Vasavi   | vasavi123    | password123   | vegetarian      | indian,jain              | Paneer Chilli,French Toast   | Monday,Tuesday         | 3,4               | 1,2              | One of the authors of this SaaS app      | 125 st, New York      | 30,40               |
    | Maya     | maya123      | password123   | non-vegetarian  | chinese,gluten-free      | Noodles,Manchurian           | Monday,Tuesday         | 3,4               | 1,1              | One of the authors of this SaaS app      | 125 st, New York      | 30,40               |
    | Tanisha  | tanisha123   | password123   | non-vegetarian  | vietnamese,gluten-free   | Pho,Pho                      | Monday,Tuesday         | 3,4               | 2,4              | One of the authors of this SaaS app      | 125 st, New York      | 30,40               |

Scenario: Chef schedules meals for the week
  Given I am on Akshay's edit page
  When I schedule the following meals for the week:
    | Day         | Meal         | Max Customers |
    | Wednesday   | Masala Naan  | 3             |
  Then my weekly meal schedule should be complete

Scenario: Chef checks assigned meals and customers
  Given I am on Vasavi's chef page
  Then I should see the following assignments:
    | Day      | Meal                  | Max Customers | Customers
    | Monday   | Paneer Chilli         | 3             | 1
    | Tuesday  | French Toast          | 4             | 2

Scenario: Chef removes a scheduled meal from the list
  Given I am on Maya's delete page
  And I have the following scheduled meals:
    | Day      | Meal         | Max Customers |
    | Monday   | Noodles      | 3             |
    | Tuesday  | Manchurian   | 4             |
  When I remove the day "Monday" from the schedule
  Then the meal "Noodles" should be removed from my schedule