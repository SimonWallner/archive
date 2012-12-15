Feature: As a developer,
  in order to show off my game,
  I want to add images to the game.

  @javascript
  Scenario: successfully upload screenshot to a game
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I choose a valid screenshot for a game
    And I submit it
    Then I should see the screenshot on the details page of the game

   @javascript
   Scenario: successfully upload multiple screenshots to a game
     Given I am signed in as User
     And I am on the games overview page
     When I follow the new game link
     And I fill in the fields with valid details for a game
     And I choose a valid screenshot for a game
     And I choose another valid screenshot for a game
     And I choose another valid screenshot for a game
     And I submit it
     Then I should see the 3 screenshots on the details page of the game

  @javascript
  Scenario: fail to upload screenshot to game page due to invalid file type
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I choose an invalid screenshot for a game
    And I submit it
    Then I should be notified on that the file is not an image file

   @javascript
   Scenario: fail to upload screenshot to game page due to a file that is too big
     Given I am signed in as User
     And I am on the games overview page
     When I follow the new game link
     And I fill in the fields with valid details for a game
     And I choose a big screenshot for a game
     And I submit it
     Then I should be notified on that the Image is too big

  @javascript
   Scenario: Remove already uploaded screenshot from game
     Given I am signed in as User
     And I have a game Tetris
     And I have a screenshot to the given game
     When I follow the game edit link
     And I remove the screenshot
     And I submit it
     Then I should not see the screenshot on the details page of the game