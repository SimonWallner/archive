Feature: Structure Content
	In order to structure the content
	As a contributor
	I want to use simplified markup ("markdown") for general text

  Scenario: create title
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with a heading
    Then I should see the developer
    And I should see the heading

  Scenario: strong text
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with a strong text
    Then I should see the developer
    And I should see the strong text

  Scenario: emphasize text
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with an emphasized text
    Then I should see the developer
    And I should see the emphasized text

  Scenario: ordered list
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with an unordered list
    Then I should see the developer
    And I should see the unordered list

  Scenario: filter html
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with html tags
    Then I should see the developer
    And I should see the html written in text

  Scenario: filter in text fields
    Given I am signed in as User
    And I am on the developer creation page
    When I try using heading markdown in the name field
    Then I should see the syntax for heading as the name

  Scenario: create paragraph
    Given I am signed in as User
    And I am on the developer creation page
    When I create a developer with two paragraphs
    Then I should see the developer
    And I should see the two paragraphs

  Scenario: short link, no name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a short link without a name
    Then I should see the game
    And I should see a short link without protocol and trailing backspace

  Scenario: long link, no name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a long link without a name
    Then I should see the game
    And I should see a long link shortened without protocol

  Scenario:  link with name
    Given I am signed in as User
    And I am on the game creation page
    When I create a game with a link with a name
    Then I should see the game
    And I should see the link as a name