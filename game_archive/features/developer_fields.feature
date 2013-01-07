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
    And I enter developer field with "Userdefined"
    And I enter developer field with "External Links"   
    And I create the developer
    Then I should see the saved Developer fields


 
    


