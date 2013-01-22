Feature: Manage Media
  In order to manage media
  As a user
  I want to add and maintain media

Background:
  Given I am signed in as Admin 
	
Scenario: show all media
  Given I have media named Online
  And I am on the media page
  Then I should see the media

Scenario: create medium
  Given I am on the medium create page
  When I create a valid medium
  Then I should see the created medium

Scenario: edit medium
  Given I have a medium named Online
  And I am on the edit page of the medium
  When I update the medium
  Then I should see the new values of Medium
  
Scenario: join medium
  Given I have a medium named Onlin
  And I am on the join page of the medium
  When I write the medium named Online
  Then I should not see the old medium