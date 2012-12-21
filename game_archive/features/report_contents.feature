Feature: Report Content
  As a visitor,
  in order to support the site,
  I want to report content that goes against the good will of the site.
  
  Scenario: User report game's page with valid data
    Given I am signed in as User
	And I have a game Tetris
    And I am on the detail page of the game
    When I follow the Report content link
    And I fill in the fields of Game reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given game

  Scenario: User report game's page with valid data
    Given I am not signed in
	And I have a game Tetris
    And I am on the detail page of the game
    When I follow the Report content link
    And I fill in the fields of Game reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given game

  Scenario: User report developer's page with valid data
    Given I am signed in as User
	And I have a developer Leela
    And I am on the detail page of the given developer
    When I follow the Report content link
    And I fill in the fields of Developer reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given developer

  Scenario: User report developer's page with valid data
    Given I am not signed in
	And I have a developer Leela
    And I am on the detail page of the given developer
    When I follow the Report content link
    And I fill in the fields of Developer reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given developer
	
  Scenario: User report company's page with valid data
    Given I am signed in as User
	And I have a company Leela
    And I am on the detail page of the given company
    When I follow the Report content link
    And I fill in the fields of Company reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given company

  Scenario: User report company's page with valid data
    Given I am not signed in
	And I have a company Leela
    And I am on the detail page of the given company
    When I follow the Report content link
    And I fill in the fields of Company reportblockcontent with valid details and submit it
    Then I should be on the detail page of the given company
	
