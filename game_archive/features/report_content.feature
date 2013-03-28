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
	
	Scenario: Report a game article
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
		
# Company Scenarios
	Scenario: Show report content link on company article
		Given I have a company AwesomeCorp
		When I visit the company article page
		Then I should see a link to the reporting form

	Scenario: Show report form for a company article
		Given I am on the company article page of AwesomeCorp
		When I follow the report content link
		Then I should be on the report article page

	Scenario: Report a company article
		Given I have a company AwesomeCorp
		And I am on the report content page
		When I fill in the report and submit it
		Then I should be on the company article page
		And I should see a thank you notice
		And The company should be reported
	
	Scenario: List company reports in the admin's report section
		Given I am signed in as Admin 
		And I have a few reports for companies
		When I visit the admin's report section
		Then I should see the reports with their details

# Developer Scenarios
	Scenario: Show report content link on developer article
		Given I have a developer Jane Doe
		When I visit the developer article page
		Then I should see a link to the reporting form

	Scenario: Show report form for a developer article
		Given I am on the developer article page of Jane Doe
		When I follow the report content link
		Then I should be on the report article page

	Scenario: Report a developer article
		Given I have a developer Jane Doe
		And I am on the report content page
		When I fill in the report and submit it
		Then I should be on the developer article page
		And I should see a thank you notice
		And The developer should be reported

	Scenario: List developer reports in the admin's report section
		Given I am signed in as Admin 
		And I have a few reports for developers
		When I visit the admin's report section
		Then I should see the reports with their details
		
#  General Scenarios
	Scenario: Show reports only to administrators not visitors
		Given I am not signed in as Admin
		When I visit the admin's report section
		Then I should be redirected to the landing page
		And I should see an access denied notice

	Scenario: Show reports only to administrators not normal users
		Given I am signed in as User
		When I visit the admin's report section
		Then I should be redirected to the landing page
		And I should see an access denied notice
	
	Scenario: Remove content report
		Given I am signed in as Admin
		And I have a few reports for games
		And I am in the admin's report section
		When I delete on of these reports
		Then that report should be deleted