Feature: Block user account
	As an administrator,
	In order to limit the damage malicious users can make,
	I want to block a user and I want to note the reason for the blocking.
	Blocked users loose all their privileges.
	
	Scenario: Fail to create content as blocked user
		Given I am signed in as Blocked
		When I visit the new game page
		Then I should be on the home page
	
	Scenario: Block user
		Given I am signed in as Admin
		And I am on the home page
		When I click on Manage Users
		And I enter an email adress of an unblocked user
		And I select Block
		And I press the Save button
		Then the user should be blocked
	
	Scenario: Fail to block user if not logged in as administrator
		Given I am signed in as User
		When I visit the Manage Users Page
		Then I should be on the home page
	
	Scenario: Fail to block user who is administrator
		Given I am signed in as Admin
		And I am on the home page
		When I click on Manage Users
		And I enter an email adress of an administrator
		And I select Block
		And I press the Save button
		Then I should be on the manage users page
	
	Scenario: Fail to block user who is already blocked
		Given I am signed in as Admin
		And I am on the home page
		When I click on Manage Users
		And I enter an email adress of a blocked user
		And I select Block
		And I press the Save button
		Then I should be on the manage users page
	
	Scenario: Unblock user
		Given I am signed in as Admin
		And I am on the home page
		When I click on Manage Users
		And I enter an email adress of a blocked user
		And I select Unblock
		And I press the Save button
		Then the user should be unblocked
	
	Scenario: Fail to unblock user who is not blocked
		Given I am signed in as Admin
		And I am on the home page
		When I click on Manage Users
		And I enter an email adress of an unblocked user
		And I select Unblock
		And I press the Save button
		Then I should be on the manage users page