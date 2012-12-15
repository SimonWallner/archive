Feature: Landingpage
	As a visitor,
	in order to get a good overview,
	I want to see a selection of games, companies, and people on the landing page.
	random pick, 5 newest, also overview pages for games, developers, companies
	
	Scenario: View featured Games on Home Page
		Given I have a selection of games
		When I am on the Home Page
		Then I should see a selection of games sorted by Newest and Most Popular
	
	Scenario: View featured Developers on Home Page
		Given I have a selection of developers
		When I am on the Home Page
		Then I should see a selection of developers sorted by Newest and Most Popular
	
	Scenario: View featured Companies on Home Page
		Given I have a selection of companies
		When I am on the Home Page
		Then I should see a selection of companies sorted by Newest and Most Popular
	
	Scenario: View random Game on Home Page
		Given I have a selection of games
		When I am on the Home Page
		Then I should see a random game pick
	
	Scenario: View random Developer on Home Page
		Given I have a selection of developers
		When I am on the Home Page
		Then I should see a random developer pick
	
	Scenario: View random Company on Home Page
		Given I have a selection of companies
		When I am on the Home Page
		Then I should see a random company pick
		
	Scenario: View featured Games on Games Page
		Given I have a selection of games
		When I am on the Games Overview Page
		Then I should see a selection of games sorted by Newest and Most Popular
		
	Scenario: View all Games on Games Page
		Given I have a selection of games
		When I am on the Games Overview Page
		Then I should see all games