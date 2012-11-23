Feature:As a contributor,
        in order to show the world how developers and games look like,
        I want to add an image to a developer and/or a game.

        Scenario: successfully upload picture for developer
            Given I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details for a developer
            And I choose a valid file for a "developer"
            And I submit it
            Then I should see the picture on the details page of the developer

        Scenario: unsuccessfully upload picture too big for developer
            Given I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details for a developer
            And I choose a file that is too big for a "developer"
            And I submit it
            Then I should be notified on that the Image is too big

        Scenario: change profile picture of developer
          Given I have a developer Hans
          And I am on the edit page of the given developer
          And I choose a valid file for a "developer"
          And I submit it
          Then I should see the picture on the details page of the developer

        Scenario: unsucsessfully upload picture too big for developer
          Given I have a developer Hans
          When I am on the edit page of the given developer
          And I choose a file that is too big for a "developer"
          And I submit it
          Then I should be notified on that the Image is too big


        Scenario: successfully upload picture to game page
          Given I am on the games overview page
          When I follow the new game link
          And I fill in the fields with valid details for a game
          And I choose a valid file for a "game"
          And I submit it
          Then I should see the picture on the details page of the game

        Scenario: unsuccessfully upload picture too big for game page
          Given I am on the games overview page
          When I follow the new game link
          And I fill in the fields with valid details for a game
          And I choose a file that is too big for a "game"
          And I submit it
          Then I should be notified on that the Image is too big

        Scenario: change profile picture of a game
          Given I have a game Tetris
          And I am on the edit page of the given game
          And I choose a valid file for a "game"
          And I submit it
          Then I should see the picture on the details page of the game

        Scenario: unsucsessfully upload picture too big for a game
          Given I have a game Tetris
          When I am on the edit page of the given game
          And I choose a file that is too big for a "game"
          And I submit it
          Then I should be notified on that the Image is too big


