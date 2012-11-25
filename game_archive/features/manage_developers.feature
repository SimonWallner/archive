Feature: Manage Developers
  As a developer,
  in order to present my game to the public,
  I want to create and manage developerpages


  Scenario: show developers page
    Given I have a developer Leela
    And I am on the developers overview page
    Then I should see the developers name in the list of developers

  Scenario: create developer with valid data
    Given I am on the developers overview page
    When I follow the new developer link
    And I fill in the fields for the developer with valid details and submit it
    Then I should see the details of the newly created developer


  Scenario: fail to create developer with empty name
    Given I am on the developer creation page
    When I leave the name field empty and submit it
    Then I should be notified of that the name must not be empty

  Scenario: update developer's page with valid data
    Given I have a developer Lori
    And I am on the detail page of the given developer
    And I follow the edit link
    When I change the developer's data and submit it
    Then I should be on the detail page of the given developer
    And I should see the updated content

  Scenario: fail to update developer with empty name
    Given I have a developer Lori
	And I am on the detail page of the given developer
    And I follow the edit link
    When I leave the name field empty and submit it
    Then I should be notified of that the name must not be empty