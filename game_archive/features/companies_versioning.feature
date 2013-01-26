Feature: As an administrator,
  in order to track changes, blame people, and revert malicious changes to content,
  I want company pages to be versioned and restorable.

  Background:
    Given I am signed in as Admin


  Scenario: successfully create a new version of a company
    Given I have a company BowserCo
    And I have a certain version number for the given company
    And I am on the edit page of the given company
    When I fill in the fields with valid details for a company
    And I submit it
    Then I should have the next version for the given company
    And I should see the link for the next version in the list of versions

  @javascript
  Scenario: compare changed content  between versions of a company
    Given I have two different versions with different data for a company
    And I am on the detail page of the given company
    When I follow the link to the previous version of the company
    Then I should see data for the old version of the company


  @javascript
  Scenario: revert to previous version and compare changed content
    Given I have two different versions with different data for a company
    And I am on the detail page of the given company
    When I follow the link to the previous version of the company
    And I revert to the previous version
    Then I should see a newly created version in the version links for a company
    And I should see data from the old version in the reverted company



