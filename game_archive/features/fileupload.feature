Feature: Profile Picture File Upload
  As a contributor,
        in order to show the world how developers and games look like,
        I want to add an image to a developer and/or a game and/or a company.

        Scenario: successfully upload picture for developer
            Given I am signed in as User
            And I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details for a developer
            And I choose a valid file for a developer
            And I submit it
            Then I should see the picture on the details page of the developer

        Scenario: unsuccessfully upload picture too big for developer
          Given I am signed in as User
          And I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details for a developer
            And I choose a file that is too big for a developer
            And I submit it
            Then I should be notified on that the Image is too big

        Scenario: unsuccessfully upload non image file to developer page
          Given I am signed in as User
          And I am on the developers overview page
          When I follow the new developer link
          And I fill in the fields with valid details for a developer
          And I choose a filetype that it not allowed for a developer
          And I submit it
          Then I should be notified on that the file is not an image file

        Scenario: change profile picture of developer
          Given I am signed in as User
          And I have a developer Hans
          And I am on the edit page of the given developer
          And I choose a valid file for a developer
          And I submit it
          Then I should see the picture on the details page of the developer

        Scenario: unsucsessfully change profile picture of a developer because the image is too big
          Given I am signed in as User
          And I have a developer Hans
          When I am on the edit page of the given developer
          And I choose a file that is too big for a developer
          And I submit it
          Then I should be notified on that the Image is too big


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


  Scenario: successfully upload picture to company page
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a valid file for a company
    And I submit it
    Then I should see the picture on the details page of the company


  Scenario: unsuccessfully upload picture too big for company
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a file that is too big for a company
    And I submit it
    Then I should be notified on that the Image is too big

  Scenario: unsuccessfully upload non image file to company page
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a filetype that it not allowed for a company
    And I submit it
    Then I should be notified on that the file is not an image file

  Scenario: change profile picture of developer
    Given I am signed in as User
    And I have a company BowserCO
    And I am on the edit page of the given company
    And I choose a valid file for a company
    And I submit it
    Then I should see the picture on the details page of the company

  Scenario: unsucsessfully change profile picture of a developer because the image is too big
    Given I am signed in as User
    And I have a company BowserCo
    When I am on the edit page of the given company
    And I choose a file that is too big for a company
    And I submit it
    Then I should be notified on that the Image is too big