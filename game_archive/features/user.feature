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
	And I am not signed in
	When I go to the sign up form
	Then I should be on the sign up page
	
  Scenario: registration with invalid token
	Given I am not invited
	And I am not signed in
	When I go to the sign up form
	Then I should be on the home page
	
  Scenario: set non-matching password
    Given I am invited
    And I am not signed in
    When I go to the sign up form
    When I sign up with passwords not matching
    Then I should be on the sign up page
	
  Scenario: set too short password
    Given I am invited
    And I am not signed in
    When I go to the sign up form
    When I sign up with a short password
    Then I should be on the sign up page
	
  Scenario: set weak password
    Given I am invited
    And I am not signed in
    When I go to the sign up form
    When I sign up with a weak password
    Then I should be on the sign up page