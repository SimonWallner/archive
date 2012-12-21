  Feature: Use Javascript
  In order to make easy inputs
  As a contributor
  I want to use javascript to aid me

  @javascript
  Scenario: Input at_link in description
    Given I am signed in as User
    And I have a game Coolgame
    And I am on the detail page of the game
    When I follow the game edit link
    And I clear the game_description field
    And I input "@" in the game_description field
    And I input "Cool" in the game_description field
    And I click the autocomplete for "Coolgame"
    And I submit the game update
    Then I should have a link to Coolgame
