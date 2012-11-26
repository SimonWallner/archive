Feature: create user account
  As a visitor,
  in order to contribute content,
  I want to create a user account for myself.

  Scenario: registration as invited new user
    Given I am invited
    And I am not signed in
    When I go to the sign up form
	And I enter and repeat a password 
    Then I should see the edit user page
	
  Scenario: registration as existing user
	Given I am invited but already registered
	And I am not signed in
	When I go to the sign up form
	Then I should see a message with already registered
	
  Scenario: registration with invalid token
	Given I am not invited
	And I am not signed in
	When I go to the sign up form
	Then I should see a message with not invited

  Scenario: set valid password
    Given I am invited
    And I am not signed in
    And I am on the sign up page
    When I sign up with a valid password
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
    
  Scenario Outline: invite user with valid data
	Given I am an administrator
	And I am signed in
	And I am on the invite user page
	When I enter the email field with a non-registered email
	And I click on the invite user button
	Then there should be a user with the email who is invited and has not accepted
	
  Scenario Outline: invite user with existing email
	Given I am an administrator
	And I am signed in
	And I am on the invite user page
	When I enter the email field with an email adress of an existing user
	And I click on the invite user button
	Then I should be notified of that the user is already registered

  Scenario Outline: reset password with valid data
	Given I am a user
	And I am signed in
	And I am on the reset password page
	When I enter a valid password
	And I click on the reset password button
	Then I should be on the home page
  
  Scenario Outline: reset password with non-matching strings
	Given I am a user
	And I am signed in
	And I am on the reset password page
	When I enter passwords not matching
	And I click on the reset password button
	Then I should be on the reset password page
	And I should see a password doesnt match error
  
  Scenario Outline: reset password with too short string
	Given I am a user
	And I am signed in
	And I am on the reset password page
	When I enter a short password
	And I click on the reset password button
	Then I should be on the reset password page
	And I should see a password too short error
  
  Scenario Outline: reset password with weak string
	Given I am a user
	And I am signed in
	And I am on the reset password page
	When I enter a weak password
	And I click on the reset password button
	Then I should be on the reset password page
	And I should see a password too weak error