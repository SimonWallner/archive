Feature: reset password
  As a user,
  in order to access my account again,
  I want to reset my password via email.

  Scenario: get email to reset password
    Given I have a user
    And I am not signed in
    And I am on the reset password page
    When I enter my email
    Then I should receive an email with password reset instructions

  Scenario: fail to get email to reset password due to an email that does not belong to any user
    Given I have a user
    And I am not signed in
    And I am on the reset password page
    When I enter an email which does not belong to a user
    Then I should see an error

  Scenario: successfully follow reset instruction link
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    Then I should be on the reset password page

  Scenario: successfully follow reset instructions and set new password
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    When I set a valid password
    Then I should be signed in
    And I should be on the home page


  Scenario: follow reset instructions and fail to change password due to an invalid password
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And I set an invalid password
    Then I should not be signed in
    And I should be on the password page
    And I should see an error


  Scenario: follow reset instructions and fail to change password due to a password that is too short
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And I set a too short password
    Then I should not be signed in
    And I should be on the password page
    And I should see an error

  Scenario: follow reset instructions and fail to change password due to a password that is blank
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And I leave the password blank
    Then I should not be signed in
    And I should be on the password page
    And I should see an error

  Scenario: follow reset instructions and fail to change password due to a password that is blank
    Given I have a user
    And I am not signed in
    And I have received a password reset email
    When I follow the reset link
    And I set a wrong confirmation password
    Then I should not be signed in
    And I should be on the password page
    And I should see an error


