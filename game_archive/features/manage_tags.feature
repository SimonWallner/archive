Feature: Manage Tags
  In order to add semantic value to entries
  As a user
  I want to add and maintain tags

Background:
  Given I am signed in as Admin 

Scenario: show all tags
  Given I have tags named BestGame
  And I am on the tags page
  Then I should see the tags

Scenario: create tag
  Given I am on the tag create page
  When I create a valid tag
  Then I should see the created tag

Scenario: edit tag
  Given I have a tag named BestGame
  And I am on the edit page of the tag
  When I update the tag
  Then I should see the new values of Tag
  
Scenario: join tag
  Given I have a tag named BestGame
  And I am on the join page of the tag
  When I write the tag named Best Game
  Then I should not see the old tag