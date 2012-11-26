Feature: reset password
  As a user,
  in order to access my account again,
  I want to reset my password via email.

  Scenario: get email to reset password
    Given I have a user
    And I am not signed in
    And I am on the login page
    When I reset my password
    Then I should receive an email with password reset instructions

  Scenario: follow reset instructions
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And I set my new password
    Then I am signed in
    And I am on the home page