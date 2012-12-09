 @active
Feature:
  As a contributor
  In order to add additional info to my company
  I want to add more information about company

  Background:
    Given I am signed in as User
 
 
  @javascript
  Scenario: insert company with fields data
    Given I am on the company fields creation page 
    When I enter company field with "Official Name" 
    Then I enter company field with "Location"
    And I enter company field with "Founded"
    And I enter company field with "Defunct"     
    And should create company 
    When The data of company be saved 
    
    
    
    
