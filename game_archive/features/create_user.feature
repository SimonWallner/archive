Feature: create user account
  As a visitor,
  in order to contribute content,
  I want to create a user account for myself.

  Scenario Outline: sign up page
    Given I am <invited>
    And I am not signed in
    When I go to the sign up page
    Then I should see <see>
    Examples:
      | invited | see |
      | invited | the sign up form |
      | not invited | a message with not invited |
      | invited but already registered | a message with already registered |


  Scenario Outline: registration progress when invited
    Given I am invited
    And I am not signed in
    And I am on the sign up page
    When I sign up with <data>
    Then I should be <where>
    And <action>
    Examples:
      | data  | where | action |
      | valid data | on the home page | I should be signed in |
      | passwords not matching | on the sign up page | I should see a password doesnt match error |
      | password is too short  | on the sign up page | I should see a password too short error    |
      | a weak password        | on the sign up page | I should see a password too weak error     |


