Feature: update account credentials
  As a user,
  just so,
  I want to change my login credentials, email address, first name and last name

  Scenario: try changing data when not signed in
    Given I am not signed in
    When I enter edit user url
    Then I should be on the sign in page

  Scenario: successfully change account data
    Given I am signed in as User
    And I am on the user edit page
    When I change all my data
    And I provide the correct password
    Then I should be on the home page
    And The data has been updated

  Scenario: unsuccessfully change account data due to wrong password
    Given I am signed in as User
    And I am on the user edit page
    When I change all my data
    And I provide the wrong password
    Then I should be on the user edit page
    And I should see an error

  Scenario: successfully change the password
    Given I am signed in as User
    And I am on the user edit page
    When I change a valid password
    And I provide the correct password
    Then I should be on the home page
    And The data has been updated


  Scenario: unsuccessfully change account data due to a too short password
    Given I am signed in as User
    And I am on the user edit page
    When I change a too short password
    And I provide the correct password
    Then I should be on the user edit page
    And I should see an error


  Scenario: unsuccessfully change account data due to an invalid password
    Given I am signed in as User
    And I am on the user edit page
    When I change an invalid password
    And I provide the correct password
    Then I should be on the user edit page
    And I should see an error

  Scenario: successfully change all data except the password
    Given I am signed in as User
    And I am on the user edit page
    When I change all my data except my password
    And I provide the correct password
    Then I should be on the home page
    And The data has been updated


  Scenario: changing email address and receive receive confirmation email
    Given I am signed in as User
    And I am on the user edit page
    When I change my email
    Then I should receive an email with confirmation instructions
    And The email has not changed yet

  Scenario: changing email address and confirm new email
    Given I am signed in as User
    And I am on the user edit page
    When I change my email
    And I confirm my email
    Then My email has been updated

