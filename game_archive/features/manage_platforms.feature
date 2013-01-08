Feature: Manage Platforms
  In order to manage platforms
  As a user
  I want to add and maintain platforms

Background:
Given I am signed in as User
  
Scenario: show all platforms
  Given I have platforms named PC
  And I am on the platforms page
  Then I should see the platforms

Scenario: create platform
  Given I am on the platform create page
  When I create a valid platform
  Then I should see the created platform

Scenario: edit platform
  Given I have a platform named PC
  And I am on the edit page of the platform
  When I update the platform
  Then I should see the new values of Platform