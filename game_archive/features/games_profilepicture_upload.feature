Feature: Profile Picture File Upload
  As a contributor,
  in order to show the world how games look like,
  I want to add an image to a game page.

  Scenario: successfully upload picture to game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I choose a valid file for a game
    And I submit it
    Then I should see the picture on the details page of the game

  Scenario: unsuccessfully upload picture too big for game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I choose a file that is too big for a game
    And I submit it
    Then I should be notified on that the Image is too big

  Scenario: change profile picture of a game
    Given I am signed in as User
    And I have a game Tetris
    And I am on the edit page of the given game
    And I choose a valid file for a game
    And I submit it
    Then I should see the picture on the details page of the game

  Scenario: unsucsessfully change profile picture for a game because the picture its too big
    Given I am signed in as User
    And I have a game Tetris
    When I am on the edit page of the given game
    And I choose a file that is too big for a game
    And I submit it
    Then I should be notified on that the Image is too big

  Scenario: unsuccessfully upload non image file to game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I choose a filetype that it not allowed for a game
    And I submit it
    Then I should be notified on that the file is not an image file