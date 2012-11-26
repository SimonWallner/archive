Feature: create user account
  As a visitor,
  in order to contribute content,
  I want to create a user account for myself.

  Scenario: registration as invited new user
    Given I am invited
    And I am not signed in
    When I go to the sign up form
	And I enter and repeat a password 
	And I click on the sign up button
    Then I should be on the home page
	
  Scenario: registration as existing user
	Given I am invited 
	And I am already registered
	And I am not signed in
	When I go to the sign up form
	Then I should be on the sign up page
	
  Scenario: registration with invalid token
	Given I am not invited
	And I am not signed in
	When I go to the sign up form
	Then I should be on the home page

  Scenario: set valid password
    Given I am invited
    And I am not signed in
    When I go to the sign up form
    And I enter and repeat a password 
    Then I should be on the home page
    And I should be signed in
	
  Scenario: set non-matching password
    Given I am invited
    And I am not signed in
    And I am on the sign up page
    When I sign up with passwords not matching
    Then I should be on the sign up page
    And I should see a password doesnt match error
	
  Scenario: set too short password
    Given I am invited
    And I am not signed in
    And I am on the sign up page
    When I sign up with a short password
    Then I should be on the sign up page
    And I should see a password too short error
	
  Scenario: set weak password
    Given I am invited
    And I am not signed in
    And I am on the sign up page
    When I sign up with a weak password
    Then I should be on the sign up page
    And I should see a password too weak error