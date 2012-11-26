Feature: account invites
  As an administrator,
  in order to get more contributors,
  I want to send out invites for user accounts.

  Scenario: send invitation when not signed in
    Given I am not signed in
    And I am on the home page
    When I enter the invitation url
    Then I should be on the home page
    And No invitation should be sent

  Scenario: send invitation when signed in with normal user
    Given I am signed in as User
    And I am on the home page
    When I enter the invitation url
    Then I should be on the home page
    And No invitation should be sent

  Scenario Outline: : send invitation when signed in as admin
    Given I am signed in as Admin
    And I am on the home page
    When I follow the send invite link
    And I enter <email>
    Then I should be <where>
    And <action>
    Examples:
    | email | where | action |
    | a valid email | on the home page | Invitation should be sent |
    | an invalid email | on the invite page | No invitation should be sent |
    | an already used email |on the invite page | I should see an email already used error |