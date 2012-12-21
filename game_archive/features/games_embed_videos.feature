Feature: As a developer,
         in order to show off my game,
         I want to embed video from popular video sites into the game entry.

  @javascript
  Scenario: sucessfully embed youtube video in game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I fill in the video field with youtube embed code
    And I submit it
    Then I should see the embedded youtube video on the details page of the game

  @javascript
  Scenario: sucessfully embed vimeo video in game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I fill in the video field with vimeo embed code
    And I submit it
    Then I should see the embedded vimeo video on the details page of the game


  @javascript
  Scenario: sucessfully embed multiple youtube and vimeo videos in game page
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I fill in the video field with youtube embed code
    And I fill in another video field with vimeo embed code
    And I fill in another video field with youtube embed code
    And I submit it
    Then I should see the 3 embedded videos on the details page of the game

  @javascript
  Scenario: fail to embed video in game page due to blank embedcode
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I fill in the video field with no embed code
    And I submit it
    Then I should not see an embedded video


  @javascript
  Scenario: fail to embed video in game page due to wrong embedcode
    Given I am signed in as User
    And I am on the games overview page
    When I follow the new game link
    And I fill in the fields with valid details for a game
    And I fill in the video field with wrong embed code
    And I submit it
    Then I should not see an embedded video








