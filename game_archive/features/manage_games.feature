Feature: Manage Games
	As a developer,
	in order to present my game to the public,
    I want to create and manage games


    Scenario: show game's page
    	Given I have a game and genre
        And I am on the game page
    	Then I should see the details of this game


    Scenario: create game and genres with valid data
        Given I am on the game overview page
        When I follow the new game link
        And I fill in the fields of game and genres with valid details and submit it
        Then the game should have been created
        And I should on the game's page


    Scenario: fail to create game with empty name
     	Given I am on the game creation page
     	When I leave the name of games  field empty and submit it
     	Then I should be notified of that the name of game must not be empty


    Scenario: update game's page with valid data
        Given I have a game name
        And I am on this game's page
 	    And I follow the edit link of game page
 	    When I change the game's data and submit it
        Then I should be on the game's page
        And I should see the updated game content