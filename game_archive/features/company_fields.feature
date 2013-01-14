Feature: Company fields
  As a contributor
  In order to add additional info to my company
  I want to add more information about company

  Background:
    Given I am signed in as User
 
 
  @javascript
  Scenario: insert company with fields data
    Given I am on the company creation page
    When I enter valid company data
    And I enter company field with "Official Name"
    And I enter company field with "Location"
    And I enter company field with "Founded"
    And I enter company field with "Defunct"     
    And I create the company
    Then I should see the saved Company fields
    
    
    
    
