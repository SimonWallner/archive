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
    When I change my data
    And I provide the <password> password
    Then I should be <where>
    And <see>

    Examples:
    | password | where | see |
    | correct  | on the home page | The data has been updated |
    | wrong    | on the user edit page | I should see an error |
