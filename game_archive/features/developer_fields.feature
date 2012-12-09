@active
Feature:
  As a contributor
  In order to add additional info to my developer
  I want to add more information about developer

  Background:
    Given I am signed in as User
 
 
  @javascript
  Scenario: insert developer with fields data
    Given I am on the developer creation page
    When I enter valid developer data 
    Then I enter field with "Developer" 
    And I enter field with "Publisher"
    And I enter field with "Distributor"
    And I enter field with "Credits" 
    And I enter field with "Release Dates" 
    And I enter field with "External Links"
    And I enter field with "Aggregate Scores"
    And I enter field with "Review Scores" 
    And I enter field with "Series"
    And I enter field with "Userdefined" 
    And should create game 
    When The data be saved
    Then I should see the saved field