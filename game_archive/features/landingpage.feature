Feature: Landingpage
	As a visitor,
	in order to get a good overview,
	I want to see a selection of games, companies, and people on the landing page.
	random pick, 5 newest, also overview pages for games, developers, companies
	
	Scenario: View newest Games on Home Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Home Page
		Then I should see a selection of games sorted by Newest
	
	Scenario: View newest Developers on Home Page
		Given I am Signed In
		And I have a selection of developers
		When I am on the Home Page
		Then I should see a selection of developers sorted by Newest
	
	Scenario: View newest Companies on Home Page
		Given I am Signed In
		And I have a selection of companies
		When I am on the Home Page
		Then I should see a selection of companies sorted by Newest
	
	Scenario: View most popular Games on Home Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Home Page
		Then I should see a selection of games sorted by Most Popular
	
	Scenario: View most popular Developers on Home Page
		Given I am Signed In
		And I have a selection of developers
		When I am on the Home Page
		Then I should see a selection of developers sorted by Most Popular
	
	Scenario: View most popular Companies on Home Page
		Given I am Signed In
		And I have a selection of companies
		When I am on the Home Page
		Then I should see a selection of companies sorted by Most Popular
		
	Scenario: View random Game on Home Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Home Page
		Then I should see a random game pick
	
	Scenario: View random Developer on Home Page
		Given I am Signed In
		And I have a selection of developers
		When I am on the Home Page
		Then I should see a random developer pick
	
	Scenario: View random Company on Home Page
		Given I am Signed In
		And I have a selection of companies
		When I am on the Home Page
		Then I should see a random company pick
		
	Scenario: View newest Games on Games Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Games Overview Page
		Then I should see a selection of games sorted by Newest
		
	Scenario: View most popular Games on Games Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Games Overview Page
		Then I should see a selection of games sorted by Most Popular
		
	Scenario: View random Game on Games Page
		Given I am Signed In
		And I have a selection of games
		When I am on the Games Overview Page
		Then I should see a random game pick