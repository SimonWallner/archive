@active
Feature:
  As a contributor
  In order to add additional info to my game
  I want to add information about developers which are linked to created devlopers

  Background:
    Given I am signed in as User

  Scenario: add developer which links to a developer
    Given I have a developer DevA
    And I am on the game creation page
    When I enter valid game data
    And I enter a developer field with a developer
    Then The data should be saved
    And I should see the developer field
