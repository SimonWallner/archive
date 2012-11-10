Feature: Manage Genres
  In order to manage genres
  As a contributor
  I want to create, update and view genres

Scenario: show all genres
  Given I have genres named Indie, Shooter
  And I am on the genres page
  Then I should see "Indie"
  And I should see "Shooter"

Scenario: create genre
  Given I am on the genres page
  When I click "New Genre"
  And I fill in "Name" with "RTS"
  And I fill in "Description" with "Realtime Strategy"
  And I click "Create Genre"
  Then I should see "Genre was successfully created"
  And I should see "RTS"
  And I should see "Realtime Strategy"

Scenario: edit genre
  Given I have a genre named "RTS"
  And I am on the edit genre_page of "RTS"
  When I fill in "Name" with "R T S"
  And I fill in "Description" with "New description"
  And I click "Update Genre"
  Then I should see "Genre was successfully updated"
  And I should see "R T S"
  And I should see "New description"