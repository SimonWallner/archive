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
  When I click "games"
  And I click "New Game"
  And I fill in "Title" with "NewGame"
  And I fill in "Description" with "new description"
  And I click "Create Game"
  Then I should see "Game was successfully created"
  And I should see "NewGame"
  And I should see "new description"

Scenario: go to edit game page
  Given I have a game titled "Tetris"
  And I am on the games page
  When I edit game named "Tetris"
  Then I should see "Edit game"
  And I can edit field with value "Tetris"

Scenario: edit game
  Given I have a game titled "Tetris"
  And I am on the edit page of "Tetris"
  When I fill in "Title" with "Tetris++"
  And I fill in "Description" with "New awesome description"
  And I click "Update Game"
  Then I should see "Game was successfully updated"
  And I should see "Tetris++"
  And I should see "New awesome description"

Scenario: view game
  Given I have a game titled "Tetris"
  And I am on the home page
  When I click "games"
  And I view game named "Tetris"
  Then I should see "Tetris"
