Feature: Manage Companies
  As an educator,
  in order to present myself,
  I want to have an entry about myself as an institution.

  Background:
    Given I am signed in as User

  Scenario: successfully show companies overview page
    Given I have a company Leela
    And I am on the companies overview page
    Then I should see the companies name in the list of companies

  Scenario: successfully create company with valid data
    Given I am on the companies overview page
    When I follow the new company link
    And I fill in the fields for the company with valid details and submit it
    Then I should see the details of the newly created company


  Scenario: fail to create company due to empty name
    Given I am on the company creation page
    When I leave the name of company field empty and submit it
    Then I should be notified of that the name of company must not be empty

  Scenario: update company's page with valid data
    Given I have a company Lori
    And I am on the detail page of the given company
    And I follow the company edit link
    When I change the company's data and submit it
    Then I should be on the detail page of the given company
    And I should see the updated content

  Scenario: fail to update company due to empty name
    Given I have a company Lori
	And I am on the detail page of the given company
    And I follow the company edit link
    When I set the name of company field empty and submit it
    Then I should be notified of that the name of company must not be empty
