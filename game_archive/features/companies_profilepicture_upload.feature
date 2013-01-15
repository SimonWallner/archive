Feature: Company Profile Picture File Upload
  As a contributor,
  in order to show the world how companies look like,
  I want to add an image to a company page.

    Scenario: successfully upload picture to company page
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a valid file for a company
    And I submit it
    Then I should see the picture on the details page of the company

    Scenario: unsuccessfully upload picture too big for company
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a file that is too big for a company
    And I submit it
    Then I should be notified on that the Image is too big

    Scenario: unsuccessfully upload non image file to company page
    Given I am signed in as User
    And I am on the companies overview page
    When I follow the new company link
    And I fill in the fields with valid details for a company
    And I choose a filetype that it not allowed for a company
    And I submit it
    Then I should be notified on that the file is not an image file

    Scenario: change profile picture of company
    Given I am signed in as User
    And I have a company BowserCO
    And I am on the edit page of the given company
    And I choose a valid file for a company
    And I submit it
    Then I should see the picture on the details page of the company

    Scenario: unsucsessfully change profile picture of a company because the image is too big
    Given I am signed in as User
    And I have a company BowserCo
    When I am on the edit page of the given company
    And I choose a file that is too big for a company
    And I submit it
    Then I should be notified on that the Image is too big