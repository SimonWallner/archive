Feature: Promote Admin
	As an administrator,
	In order to grant more power to certain users,
	I want to promote a user to an administrator
	Demote as well,
	Search by either user's name or email
	
	Scenario: promote user by email
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter a valid user email adress
		And I select Promote
		And I press the Save button
		Then I should be on the home page
	
	Scenario: promote user by full name
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter a valid full name
		And I select Promote
		And I press the Save button
		Then I should be on the home page
	
	Scenario: demote admin by email
		Given I am signed in as Admin
		And I have a user who is admin
		And I am on the home page
		When I go to the promote admin page
		And I enter a valid user email adress
		And I select Demote
		And I press the Save button
		Then I should be on the home page
	
	Scenario: demote admin by full name
		Given I am signed in as Admin
		And I have a user who is admin
		And I am on the home page
		When I go to the promote admin page
		And I enter a valid full name
		And I select Demote
		And I press the Save button
		Then I should be on the home page
	
	Scenario: fail to promote user by wrong email
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter an invalid email adress
		And I select Promote
		And I press the Save button
		Then I should be on the promote admin page
	
	Scenario: fail to promote user by wrong name
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter an invalid full name
		And I select Promote
		And I press the Save button
		Then I should be on the promote admin page
	
	Scenario: fail to promote user by firstname
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter only a firstname
		And I select Promote
		And I press the Save button
		Then I should be on the promote admin page
	
	Scenario: fail to promote user who is already admin
		Given I am signed in as Admin
		And I have a user who is admin
		And I am on the home page
		When I go to the promote admin page
		And I enter an admin email
		And I select Promote
		And I press the Save button
		Then I should be on the promote admin page
	
	Scenario: fail to demote user who is not admin
		Given I am signed in as Admin
		And I have a user who is not admin
		And I am on the home page
		When I go to the promote admin page
		And I enter a user email
		And I select Demote
		And I press the Save button
		Then I should be on the promote admin page
	
	Scenario: fail to promote user without having administrator rights
		Given I am signed in as user
		And I have a user who is not admin
		When I enter the promote admin page adress
		Then I should be on the home page