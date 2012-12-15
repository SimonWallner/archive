Feature: Structure Content
  In order to structure the content
  As a contributor
  I want to use simplified markup ("markdown") for general text on the developer page

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
