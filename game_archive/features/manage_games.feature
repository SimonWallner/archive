Feature: Manage Games
  In order to manage games
  As a contributor
  I want to create, update and view game pages

Scenario: show all games
  Given I have games titled Tetris, Pacman
  And I am on the games page
  Then I should see "Tetris"
  And I should see "Pacman"

Scenario: create game
  Given I am on the home page
  Then I go to the games page
  And I click "New Game"
  And I fill in "title" with "NewGame"
  And I fill in "description" with "new description"
  And I click "Create"
  Then I am on the game's page "NewGame"
  And I should see "NewGame"
  And I should see "new description"