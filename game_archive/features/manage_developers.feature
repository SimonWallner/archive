Feature: Manage Developers
	As a developer,
	in order to present my game to the public,
    I want to create and manage developerpages


    Scenario: show developer's page
    	Given I have a developer Leela
        When I am on the developer's page
    	Then I should see their details

    Scenario: create developer with valid data
        Given I am on the devlopers overview page
        When I follow the new developer link
        And I fill in the fields with valid details and submit it
        Then The devloper should have been created
        And I should on the developer's page


    Scenario: fail to create developer with empty name
     	Given I am on the developer creation page
     	When I leave the name field empty and submit it
     	Then I should be notified of that the name must not be empty

    Scenario: update developer's page with valid data
        Given I have a developer Lori
        And I am on her developer's page
 	    And I follow the edit link
 	    When I change the devloper's data and submit it
        Then I should be on the devloper's page
        And I should see the updated content

