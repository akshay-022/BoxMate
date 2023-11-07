Feature: Customer's Schedule and Meal Assignment

  As a customer
  So that I can plan my meals effectively
  I want to schedule meals for each day, specifying the chef, and the option to remove meals.

Background: Customers Database
  Given the following customers exist in the database:
    | name    | username    | password     | food_constraint | tags           | days           | chefs              | needs | description                               |
    | Omkar   | omkar123    | password123  | vegetarian      | indian,jain    | Monday,Tuesday | Akshay,Vasavi      | true  | One of the authors of this SaaS app       |
    | Akshat  | akshat123   | password123  | vegetarian      | indian,jain    | Monday,Tuesday | Vasavi,Vasavi      | true  | One of the authors of this SaaS app       |
    | Abhinav | abhinav123  | password123  | vegetarian      | indian,jain    | Monday,Tuesday | Tanisha,Maya       | true  | One of the authors of this SaaS app       |


Scenario: Customer checks schedule
  Given I am on Akshat's customer page
  Then I should see the following schedule:
    | Day      | Chef    |
    | Monday   | Vasavi  |
    | Tuesday  | Vasavi  |

Scenario: Customer removes a scheduled meal
  Given I am on Abhinav's delete customer page
  And I have the following schedule:
    | Day      | Chef    |
    | Monday   | Tanisha |
    | Tuesday  | Maya    |
  When I remove the day "Monday" from the schedule of customer
  Then the chef "Tanisha" should be removed from my schedule

Scenario: Customer adds meals to their schedule
  Given I am on Akshat's create customer page
  When I add the following meals to my schedule:
    | Day         | Chef    |
    | Tuesday     | Maya    |
  Then my meal schedule should be updated