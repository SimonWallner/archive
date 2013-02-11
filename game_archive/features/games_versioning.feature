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
		
	Scenario: Show links to available Versions
		Given I have 3 versions of the game Tetris
		When I visit the game article page
		Then I should see links to all available versions
		
	Scenario: Follow version link to a given game article version
		Given I have 3 versions of the game Tetris
		When I visit the game article page
		And I follow the link to another version
		Then I should see this version of the game article
		
	Scenario: Show link to restore version on the article page for a specific version
		Given I have 3 versions of the game Tetris
		When I visit the game page for a specific version
		Then I should see a link to restore this version
	
	@javascript
	Scenario: Restore a certain version
		Given I have 3 versions of the game Tetris
		When I visit the game page for a specific version
		And follow the restore link
		Then I should be on the game article page showing the restored version
