Feature: Manage Developers
    In order to make a developerpage
    As a Contributor
    I want to create and manage developerpages

    Scenario: show developers
        Given I have developers titled Hans, Hugo
        When I go to the developers page
        Then I should see "Hans"
        And I should see "Hugo"

    Scenario: create developer
        Given I am on the home page
        When I click "people"
        #....

    Scenario: update developers page
        Given I have a developer "Hans" with the description "toller"
        When I go to the developers page
        Then I should see "Hans"
        When I click "Hans" 
        Then I should see "Edit"
        When I click the button "Edit"
        And I fill in titel with "Hans" and content with "untoller"
        And I click the button "update developer"
        Then I should see "Hans"

    #further scenarios are, create developer page, 





