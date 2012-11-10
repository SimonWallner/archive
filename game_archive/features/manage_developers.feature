Feature: Manage Developers
    In order to make a developerpage
    As a Contributor
    I want to create and manage developerpages

    Scenario: show developers
        Given I have developers named Hans, Hugo
        When I go to the developers page
        Then I should see "Hans"
        And I should see "Hugo"

    Scenario: create developer
        Given I am on the home page
        When I click "people"
        Then I click "New Developer"
        And I fill in "Name" with "Hans"
        And I fill in "Description" with "super programmierer"
        And I click "Create Developer"
        Then I should see "Developer was successfully created"
        And I should see "Hans"

    Scenario: update developers page
        Given I have a developer "Hans" with the description "toller"
        When I go to the developers page
        Then I should see "Hans"
        When I click "Hans" 
        Then I should see "Hans"
        And I should see "toller"
        When I click "Edit"
        And I fill in "Name" with "Hans"
        And I fill in "Description" with "untoller"
        And I click "Update Developer"
        Then I should see "Hans"
        And I should see "untoller"

    Scenario: show developers page
        Given I have a developer named "Hans"
        When I go to the developers page
        Then I should see "Hans"
        When I click "Hans"
        Then I should see "Hans" 
        And I should see "Hans" 

    #further scenarios are, create developer page, 





