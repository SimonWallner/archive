Feature:
  As a contributor
  In order to add additional info to my game
  I want to add different fields with content to my game

  Background:
    Given I am signed in as User

  @javascript
  Scenario: add developer which links to a developer
    Given I have a developer DevA
    And I am on the game creation page
    When I enter valid game data
    And I add the field Genres
    And I enter a developer field with a developer
    Then The data should be saved
    And I should see the developer field

  @javascript
  Scenario: insert new genres
    Given I have a game Tetris
    And I have a genre named Puzzle
    And I am on the detail page of the game
    When I follow the game edit link
    And I add the field Genres
    And I input "Pu" in the new_genres_input field
    And I click the autocomplete for "Puzzle"
    Then I should have genre "Puzzle" added