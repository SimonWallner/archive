Feature: As a developer,
         in order to show off my game,
         I want to embed video from popular video sites into the game entry.


  Scenario: sucessfully embed youtube video in game page
            Given I am signed in as User
            And I am on the games overview page
            When I follow the new game link
            And I fill in the fields with valid details for a game
            And I fill in the first video field with a youtube embed code
            And I submit it
            Then I should see the embedded video on the details page of the game

  Scenario: sucessfully embed multiple youtube videos in game page
          Given I am signed in as User
          And I am on the games overview page
          When I follow the new game link
          And I fill in the fields with valid details for a game
          And I fill in the first video field with a youtube embed code
          Then I should not see a second field for the embed code
          When I click the add video button
          Then I should see a second field for the embed code
          When I fill in the second video field with a youtube embed code
          And I submit it
          Then I should see the embedded videos on the details page of the game





