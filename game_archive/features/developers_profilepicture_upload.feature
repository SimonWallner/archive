Feature: Profile Picture File Upload
  As a contributor,
  in order to show the world how developers and games look like,
  I want to add an image to a developer page.

  Scenario: successfully upload picture for developer
    Given I am signed in as User
    And I am on the developers overview page
    When I follow the new developer link
    And I fill in the fields with valid details for a developer
    And I choose a valid file for a developer
    And I submit it
    Then I should see the picture on the details page of the developer

  Scenario: unsuccessfully upload picture too big for developer
    Given I am signed in as User
    And I am on the developers overview page
    When I follow the new developer link
    And I fill in the fields with valid details for a developer
    And I choose a file that is too big for a developer
    And I submit it
    Then I should be notified on that the Image is too big

  Scenario: unsuccessfully upload non image file to developer page
    Given I am signed in as User
    And I am on the developers overview page
    When I follow the new developer link
    And I fill in the fields with valid details for a developer
    And I choose a filetype that it not allowed for a developer
    And I submit it
    Then I should be notified on that the file is not an image file

  Scenario: change profile picture of developer
    Given I am signed in as User
    And I have a developer Hans
    And I am on the edit page of the given developer
    And I choose a valid file for a developer
    And I submit it
    Then I should see the picture on the details page of the developer

  Scenario: unsucsessfully change profile picture of a developer because the image is too big
    Given I am signed in as User
    And I have a developer Hans
    When I am on the edit page of the given developer
    And I choose a file that is too big for a developer
    And I submit it
    Then I should be notified on that the Image is too big
