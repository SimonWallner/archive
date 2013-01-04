Feature: Search content
	As a visitor,
	in order to find specific content,
	I want to search content by different criteria.
	
	Scenario: Search for exact name of existing game
		Given I have a game Tetris
		And I am on the Search Page
		When I enter Tetris
		And I click the Search button
		Then I should have the game in the search results
		
	Scenario: Search for exact name of existing game, developer, company
		Given I have a game Tetris
		And I have a developer Tetris
		And I have a company Tetris
		And I am on the Search Page
		When I enter Tetris
		And I click the Search button
		Then I should have all three in the search results
	
	Scenario: Search for a part of the name of existing developer
		Given I have a developer Will Wright
		And I am on the Search Page
		When I enter Will
		And I click the Search button
		Then I should have the developer in the search results
	
	Scenario: Search for description content of existing company
		Given I have a company with description Tetris Developer
		And I am on the Search Page
		When I enter Tetris
		And I click the Search button
		Then I should have the company in the search results
	
	Scenario: Search for non-existant game
		Given I have a game Tertis
		And I am on the Search Page
		When I enter Tetris
		And I click the Search button
		Then I should have no search results