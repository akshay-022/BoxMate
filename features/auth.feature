Feature: User Authentication

  As a user
  So that I can use the platform
  I want to be able to sign up, sign in, and log out.

  Background: Seed Database with Chef and Customer Information
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

  Scenario: Customer signs up
    Given I am on customer signup page
    When I fill in the customer signup form with valid details
      | field                   | value          |
      | name                    | Manasa         |
      | username                | manasalucky    |
      | password                | password123    |
      | food_constraint         | vegetarian     |
      | tags                    | indian,jain    |
      | description             | One of the authors |
      | address                 | 118 st, New York |
      | address_coordinates_x   | 50             |
      | address_coordinates_y   | 80             |
    And I submit the signup form
    Then I should see a success message
    Then I should be redirected to the login page

  Scenario: Chef signs up
    Given I am on chef signup page
    When I fill in the chef signup form with valid details
      | field                   | value          |
      | name                    | Manasa         |
      | username                | manasalucky    |
      | password                | password123    |
      | food_constraint         | vegetarian     |
      | tags                    | indian,jain    |
      | description             | One of the authors |
      | address                 | 118 st, New York |
      | address_coordinates_x   | 50             |
      | address_coordinates_y   | 80             |
    And I submit the signup form
    Then I should see a success message
    Then I should be redirected to the login page

  Scenario: Customer logs in
    Given I am on login page
    When I fill in the customer login form with:
      | field                   | value          |
      | username                | omkar123       |
      | password                | password123    |
    And I submit the login form
    Then I am on Omkar's customer main page

  Scenario: Chef logs in
    Given I am on login page
    When I fill in the chef login form with:
      | field                   | value          |
      | username                | tanisha123     |
      | password                | password123    |
    And I submit the login form
    Then I am on Tanisha's chef main page

  Scenario: Customer logs in with invalid password
    Given I am on login page
    When I fill in the customer login form with:
      | field                   | value          |
      | username                | omkar123       |
      | password                | password23     |
    And I submit the login form
    Then I should see an error message for password
    And I should remain on the login page

  Scenario: Customer logs in with invalid username
    Given I am on login page
    When I fill in the customer login form with:
      | field                   | value          |
      | username                | omkar1         |
      | password                | password123    |
    And I submit the login form
    Then I should see an error message for username
    And I should remain on the login page

  Scenario: Chef logs in with invalid password
    Given I am on login page
    When I fill in the chef login form with:
      | field                   | value        |
      | username                | tanisha123   |
      | password                | password3    |
    And I submit the login form
    Then I should see an error message for password
    And I should remain on the login page

  Scenario: Chef logs in with invalid username
    Given I am on login page
    When I fill in the chef login form with:
      | field                   | value        |
      | username                | tanisha3     |
      | password                | password123  |
    And I submit the login form
    Then I should see an error message for username
    And I should remain on the login page