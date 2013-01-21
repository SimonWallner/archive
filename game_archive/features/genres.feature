Feature: Manage Genres
  In order to manage genres
  As a contributor
  I want to create, update and view genres
  
Background:
  Given I am signed in as Admin 

Scenario: show all genres
  Given I have genres named Indie, Shooter
  And I am on the genres page
  Then I should see the genres

Scenario: create genre
  Given I am on the genre create page
  When I create a valid genre
  Then I should see the created genre

Scenario: edit genre
  Given I have a genre named RTS
  And I am on the edit page of the genre
  When I update the genre
  Then I should see the new values
  
Scenario: join genre
  Given I have a genre named Shoter
  And I am on the join page of the genre
  When I write the genre named Shooter
  Then I should not see the old genre