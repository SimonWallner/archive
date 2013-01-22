Feature: Manage Modes
  In order to manage modes
  As a user
  I want to add and maintain modes

Background:
  Given I am signed in as Admin 
  
Scenario: show all modes
  Given I have modes named Single Player
  And I am on the modes page
  Then I should see the modes

Scenario: create mode
  Given I am on the mode create page
  When I create a valid mode
  Then I should see the created mode

Scenario: edit mode
  Given I have a mode named Single Player
  And I am on the edit page of the mode
  When I update the mode
  Then I should see the new values of Mode
  
Scenario: join mode
  Given I have a mode named Single Playe
  And I am on the join page of the mode
  When I write the mode named Single Player
  Then I should not see the old mode