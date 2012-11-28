@active
Feature: update account credentials
  As a user,
  just so,
  I want to change my login credentials, email address, first name and last name

  Scenario: try changing data when not signed in
    Given I am not signed in
    When I enter edit user url
    Then I should be redirected to the sign in page

  Scenario Outline: changing data
    Given I am signed in as User
    And I am on the user edit page
    When I change <data>
    And I provide the <password> password
    Then I should be <where>
    And <see>

    Examples:
    | data | password | where | see |
    | all my data | correct  | on the home page | The data has been updated |
    | all my data | wrong    | on the user edit page | I should see an error |
    | a valid password | correct | on the home page  | The data has been updated |
    | a too short password | correct | on the user edit page  | I should see an error |
    | an invalid password | correct | on the user edit page  | I should see an error |
    | all my data except my password | correct | on the home page  | The data has been updated |
