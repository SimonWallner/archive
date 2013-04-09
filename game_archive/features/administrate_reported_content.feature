Feature: administrate reported content
	As a site administrator,
	in order to react quickly to reported content,
	I want to receive email notifications on reports.
	
	Scenario: Send notification to all administrators when a new report comes in
		Given there are a few administrators
		And I have a game Tetris
		And no emails have been sent
		When I report that game
		Then an email with the report should be sent to all administrators
			
	# Scenario: notify on article lock of user
	# 	Given I am signed in as Admin
	# 	And I have a game Tetris2
	# 	When I lock the game
	# 	Then there should be an email sent to the admin with valid information
	# 
	# Scenario: notify on article block of user
	# 	Given I am signed in as Admin
	# 	And I have a game Tetris3
	# 	When I block the game
	# 	Then there should be an email sent to the admin with valid information
	# 
	# Scenario: do not notify on article unblock
	# 	Given I am signed in as Admin
	# 	And I have a blocked game
	# 	When I unblock the game
	# 	Then there should not be an email sent to the admin