Feature: As an administrator,
  in order to track changes, blame people, and revert malicious changes to content,
  I want game pages to be versioned and restorable.

  Background:
    Given I am signed in as Admin


  Scenario: successfully create a new version of a game
    Given I have a game Tetris
    And I have a certain version number for the given game
    And I am on the edit page of the given game
    When I fill in the fields with valid details for a game
    And I submit it
    Then I should have the next version for the given game
    And I should see the link for the next version in the list of versions

#  @javascript
#  Scenario: compare changed content  between versions of a game
#    Given I have two different versions with different data for a game
#    And I am on the detail page of the game
#    When I follow the link to the previous version of the game
#    Then I should see data for the old version of the game

#  @javascript
#  Scenario: revert to previous version and compare changed content
#    Given I have two different versions with different data for a game
#    And I am on the detail page of the game
#    When I follow the link to the previous version of the game
#    And I revert to the previous version
#    Then I should see a newly created version in the version links for a game
#    And I should see data from the old version in the reverted game

