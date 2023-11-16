Feature: Customer Management

  As a customer
  So that I can plan my meals effectively
  I want to schedule meals for each day, specifying the chef, and the option to remove meals.

  Background:
    Given the following chefs exist in the database:
      | name    | username  | password     | food_constraint | tags                     | description                            | address            | address_coordinates |
      | Akshay  | aksh123   | password123  | vegetarian      | indian,gluten-free       | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |
      | Vasavi  | vasavi123 | password123  | vegetarian      | indian,jain              | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |
      | Maya    | maya123   | password123  | non-vegetarian  | chinese,gluten-free      | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |
      | Tanisha | tanisha123| password123  | non-vegetarian  | vietnamese,gluten-free   | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |

    Given the following customers exist in the database:
      | name    | username   | password    | food_constraint | tags                    | description                             | address            | address_coordinates |
      | Omkar   | omkar123   | password123 | vegetarian      | indian,jain             | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |
      | Akshat  | akshat123  | password123 | vegetarian      | indian,jain             | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |
      | Abhinav | abhinav123 | password123 | vegetarian      | indian,jain             | One of the authors of this SaaS app    | 125 st, New York   | 30,40               |

    Given the following chef meals exist in the database:
      | username  | meal                   | days                  | mealtime | max_customers | num_customers | chefinfo_id | cuisine      |
      | aksh123   | Paneer Butter Masala   | 2023-11-15            | Lunch    | 3             | 2             | 1           | indian       |
      | aksh123   | Egg fry                | 2023-11-16            | Lunch    | 4             | 2             | 1           | chinese      |
      | vasavi123 | Paneer Chilli          | 2023-11-15            | Lunch    | 3             | 2             | 2           | vietnamese   |
      | vasavi123 | French Toast           | 2023-11-16            | Lunch    | 4             | 0             | 2           | jain         |
      | maya123   | Noodles                | 2023-11-15            | Lunch    | 3             | 0             | 3           | gluten-free  |
      | maya123   | Manchurian             | 2023-11-16            | Lunch    | 4             | 0             | 3           | chinese      |
      | tanisha123| Pho                    | 2023-11-15            | Lunch    | 3             | 0             | 4           | indian       |
      | tanisha123| Pho                    | 2023-11-16            | Lunch    | 4             | 0             | 4           | jain         |

    Given the following customer meals exist in the database:
      | username    | chefmeal_id | customerinfo_id |
      | omkar123    | 1           | 1               |
      | omkar123    | 2           | 1               |
      | akshat123   | 3           | 2               |
      | akshat123   | 4           | 2               |
      | abhinav123  | 5           | 3               |
      | abhinav123  | 6           | 3               |


    Given I am on login page
    When I fill in the customer login form with:
      | field       | value       |
      | username    | omkar123    |
      | password    | password123 |
    And I submit the login form

  Scenario: Customer views their profile
    Then I am on Omkar's customer main page
    And page contains "This is what your week looks like!!"

  Scenario: Customer checks assigned meals and chefs
    Then I should see the following assignments:
      | Day        | Mealtime | Meal                 | Chef   |
      | 2023-11-15 | Lunch    | Paneer Butter Masala | Akshay |
      | 2023-11-16 | Lunch    | Egg fry              | Akshay |

  Scenario: Customer removes a scheduled meal
    When I click "Remove an entry" button
    Then I am on Omkar's customer delete meal page
    And I click on the "Destroy" button for the customer meal with id "2"
    And I accept the alert
    And page contains "Your entry was successfully deleted!"
    And page does not contain "Egg fry"

  Scenario: Customer adds a scheduled meal
    When I click "Change your schedule" button
    Then I am on Omkar's customer edit meal page
    And I click the "Add to meals" button for the chef meal with id "5"
    And page contains "Your choice was successfully updated!"
    And page contains "Noodles"

  Scenario: Customer logs out
    When I click "Logout" button
    Then I am on login page
    And page contains "Login Form"