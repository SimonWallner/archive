Feature: As an administrator,
  in order to track changes, blame people, and revert malicious changes to content,
  I want developer pages to be versioned and restorable.

  Background: 
    Given I am signed in as Admin


  Scenario: successfully create a new version of a developer page
    Given I have a developer Hugo
    And I have a certain version number for the given developer
    And I am on the edit page of the given developer
    When I fill in the fields with valid details for a developer
    And I submit it
    Then I should have the next version for the given developer
    And I should see the link for the next version in the list of versions


  Scenario: compare changed content  between versions of a developer page
    Given I have two different versions with different data for the developer Hans
    And I am on the detail page of the given developer
    When I follow the link to the previous version
    Then I should see different data


