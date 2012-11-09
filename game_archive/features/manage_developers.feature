Feature: Manage Developers
    In order to make a developerpage
    As a Contributor
    I want to create and manage developerpages

    Scenario: show Developers List
        Given I have developers titled Hans, Hugo
        When I go to the developers page
        Then I should see "Hans"
        And I should see "Hugo"

    Scenario: update a Developers page
        Given I have a developer "Hans" with the description "toller"
        When I go to the developers page
        And I should see "Hans"
        And I click "Hans" 
        And I click "Edit"
        And i fill in titel with "Hans" and content with "untoller"
        And i click update developer
        Then i should see the titel





