Feature: administrate reported contents
	As a site administrator,
	in order to react quickly to reported content,
	I want to receive email notifications on reports.
	
	Scenario: notify on article report of visitor
		Given I am not signed in
		And I have a game Tetris
		And there is an administrator admin
		When I report the game
		Then there should be an email sent to the admin with valid information
	
	Scenario: notify on article lock of user
		Given I am signed in as Admin
		And I have a game Tetris2
		When I lock the game
		Then there should be an email sent to the admin with valid information
	
	Scenario: notify on article block of user
		Given I am signed in as Admin
		And I have a game Tetris3
		When I block the game
		Then there should be an email sent to the admin with valid information
	
	Scenario: do not notify on article unblock
		Given I am signed in as Admin
		And I have a blocked game
		When I unblock the game
		Then there should not be an email sent to the admin