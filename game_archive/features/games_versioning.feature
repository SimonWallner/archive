Feature: As an administrator,
  in order to track changes, blame people, and revert malicious changes to content,
  I want game pages to be versioned and restorable.

  Background:
    Given I am signed in as User


  Scenario: New version should be created when the game article is edited
    Given I have a game Tetris
		When I edit the game article
    Then I should be on the game article page showing the new version

	Scenario: Always show current version of game.
		Given I have 3 versions of the game Tetris
		When I visit the game article with an id from an older version
		Then I should see the current version of the game

	Scenario: View a specific game version
		Given I have 3 versions of the game Tetris
		When I visit the game page for a specific version
		Then I should see this version of the game article
		
	Scenario: Show current Version number
		Given I have 3 versions of the game Tetris
		When I visit the game article page
		Then I should see the current version number




#  Scenario: revert to previous version and compare changed content
#    Given I have two different versions with different data for a game
#    And I am on the detail page of the game
#    When I follow the link to the previous version of the game
#    And I revert to the previous version
#    Then I should see a newly created version in the version links for a game
#    And I should see data from the old version in the reverted game

