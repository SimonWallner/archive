@active
Feature:
  As a contributor
  In order to add additional info to my developer
  I want to add more information about developer

  Background:
    Given I am signed in as User
 
 
  @javascript
  Scenario: insert developer with fields data
    Given I am on the developer fields creation page 
    And I enter developer field with "Userdefined"
    And I enter developer field with "External Links"   
    And should create developer 
    When The data of developer be saved   


 
    


