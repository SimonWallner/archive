Feature: reset password
  As a user,
  in order to access my account again,
  I want to reset my password via email.

  Scenario Outline: get email to reset password
    Given I have a user
    And I am not signed in
    And I am on the reset password page
    When <email>
    Then <result>

    Examples:
    | email | result |
    | I enter my email | I should receive an email with password reset instructions |
    | I enter an email which does not belong to a user | I should see an error      |


  Scenario Outline: follow reset instructions
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And <action>
    Then I should <signedin>
    And <where>
    And <error>

    Examples:
    | action | signedin | where | error |
    | I set a valid password | be signed in | I should be on the home page | I should not see an error |
    | I set an invalid password   | not be signed in | I should be on the password page | I should see an error |
    | I set a too short password  | not be signed in | I should be on the password page | I should see an error |
    | I leave the password blank  | not be signed in | I should be on the password page | I should see an error |
    | I set a wrong confirmation password | not be signed in | I should be on the password page | I should see an error |
