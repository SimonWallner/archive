Feature: account invites
  As an administrator,
  in order to get more contributors,
  I want to send out invites for user accounts.

  Scenario: fail to send invitation when not signed in
    Given I am not signed in
    And I am on the home page
    When I enter the invitation url
    Then I should be on the home page
    And No invitation should be sent


  Scenario: fail to send invitation when signed in with normal user
    Given I am signed in as User
    And I am on the home page
    When I enter the invitation url
    Then I should be on the home page

  Scenario: send valid invitation when signed in as admin
    Given I am signed in as Admin
    And I am on the home page
    When I follow the send invite link
    And I enter a valid email
    Then I should be on the home page
    And an invitation should be sent

  Scenario: fail to send invitation due to invalid email address
    Given I am signed in as Admin
    And I am on the home page
    When I follow the send invite link
    And I enter an invalid email
    Then I should be on the invite page
    And No invitation should be sent

  Scenario: fail to send invitation due to an already used email address
    Given I am signed in as Admin
    And I am on the home page
    When I follow the send invite link
    And I enter an already used email
    Then I should be on the invite page
    And I should see an email already used error







