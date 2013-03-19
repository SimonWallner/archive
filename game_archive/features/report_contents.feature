Feature: Report Content
  As a visitor,
  in order to support the site,
  I want to report content that goes against the good will of the site.
  
	Scenario: Show report content link on game article
		Given I have a game Doom
		When I visit the game article page
		Then I should see a link to the reporting form
	
	Scenario: Show report form for a game article
		Given I am on the game article page of Doom
		When I follow the report content link
		Then I should be on the report article page
	
	Scenario: Report a game
		Given I have a game Tetris
		And I am on the report content page
		When I fill in the report and submit it
		Then I should be on the game article page
		And I should see a thank you notice
		And The game should be reported
		
	Scenario: List game reports in the admin's report section
		Given I am signed in as Admin 
		And I have a few reports for games
		When I visit the admin's report section
		Then I should see the reports with their details
	
	# Scenario: Show reports only to administrators
	# 	Given I am not signed in as Admin
	# 	When I visit the admin's report section
	# 	Then I should be redirected to the landing page
	# 	And I should see access denied notice
		
		  # 
		  # 
		  # Scenario: User report game's page with valid data
		  #   Given I am signed in as User
		  # 		And I have a game Tetris
		  #   And I am on the detail page of the game
		  #   When I follow the Report content link
		  #   And I fill in the fields of Game reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given game
		  # 
		  # Scenario: User report game's page with valid data
		  #   Given I am not signed in
		  # 		And I have a game Tetris
		  #   And I am on the detail page of the game
		  #   When I follow the Report content link
		  #   And I fill in the fields of Game reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given game
		  # 
		  # Scenario: User report developer's page with valid data
		  #   Given I am signed in as User
		  # 		And I have a developer Leela
		  #   And I am on the detail page of the given developer
		  #   When I follow the Report content link
		  #   And I fill in the fields of Developer reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given developer
		  # 
		  # Scenario: User report developer's page with valid data
		  #   Given I am not signed in
		  # 		And I have a developer Leela
		  #   And I am on the detail page of the given developer
		  #   When I follow the Report content link
		  #   And I fill in the fields of Developer reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given developer
		  # 	
		  # Scenario: User report company's page with valid data
		  #   Given I am signed in as User
		  # 		And I have a company Leela
		  #   And I am on the detail page of the given company
		  #   When I follow the Report content link
		  #   And I fill in the fields of Company reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given company
		  # 
		  # Scenario: User report company's page with valid data
		  #   Given I am not signed in
		  # 		And I have a company Leela
		  #   And I am on the detail page of the given company
		  #   When I follow the Report content link
		  #   And I fill in the fields of Company reportblockcontent with valid details and submit it
		  #   Then I should be on the detail page of the given company
		  # 	
		