Feature: Manage Games
  As a developer,
  in order to present my game to the public,
  I want to create and manage games

  Background:
    Given I am signed in as User

  Scenario: show games page
    Given I have a game Tetris
    And I am on the games overview page
    Then I should see the title of the game in a list of games


  Scenario: create game and genres with valid data
    Given I am on the games overview page
    When I follow the new game link
    And I fill in the fields of game and genres with valid details and submit it
    And I should see the details of the newly created game


  Scenario: fail to create game with empty name
    Given I am on the game creation page
    When I leave the name of games field empty and submit it
    Then I should be notified of that the name of game must not be empty


  Scenario: update game's page with valid data
    Given I have a game Tetris
    And I have a genre named "Puzzle"
    And I am on the detail page of the game
    When I follow the game edit link
    And I change the game's data and submit it
    Then I should see the updated game content
    And I should be on the detail page of the given game
	
  Scenario: fail to update game with empty name
    Given I have a game Tetris
	And I am on the detail page of the game
    When I follow the game edit link
    And I set the name of games field empty and submit it
    Then I should be notified of that the name of game must not be empty
