Feature: Delete content
  As a contributor,
  in order to get rid of content that was created in error,
  I want to delete content  As an administrator,

  Scenario: User delete game's page with valid data
    Given I am signed in as User
	And I have a game Tetris
    And I am on the detail page of the game
    When I follow the Delete content link
	And I fill in the fields of Game deletecontent with valid details and submit it
    Then I should be on the detail page of the given game
	
  Scenario: User undelete game's page with valid data
    Given I am signed in as User
	And I have a deleted game
	And I am on the detail page of the game
    When I follow the Undelete content link
	And I press the Undelete button in Report page
    Then I should be on the detail page of the given game

  Scenario: User delete developer's page with valid data
    Given I am signed in as User
	And I have a developer Leela
	And I am on the detail page of the given developer
    When I follow the Delete content link
	And I fill in the fields of Developer deletecontent with valid details and submit it
    Then I should be on the detail page of the given developer
	
  Scenario: User undelete developer's page with valid data
    Given I am signed in as User
	And I have a deleted developer
	And I am on the detail page of the given developer
    When I follow the Undelete content link
	And I press the Undelete button in Report page
    Then I should be on the detail page of the given developer
	
  Scenario: User delete company's page with valid data
    Given I am signed in as User
	And I have a company Leela
	And I am on the detail page of the given company
    When I follow the Delete content link
	And I fill in the fields of Company deletecontent with valid details and submit it
    Then I should be on the detail page of the given company
	
  Scenario: User undelete company's page with valid data
    Given I am signed in as User
	And I have a deleted company
	And I am on the detail page of the given company
    When I follow the Undelete content link
	And I press the Undelete button in Report page
    Then I should be on the detail page of the given company
	
  Scenario: User can not see deleted game
    Given I am signed in as User
	And I have a deleted game
    When I am on the games overview page
	Then I should not see deleted game

  Scenario: Visitor can not see deleted game
    Given I am not signed in
	And I have a deleted game
    When I am on the games overview page
	Then I should not see deleted game
	
  Scenario: Visitor can not show deleted game
    Given I am not signed in
    And I am on the games overview page
	And I have a deleted game 
	When I enter the game detail page
	Then I should be on the home page
	
  Scenario: User can not see deleted developer
    Given I am signed in as User
	And I have a deleted developer
    When I am on the developers overview page
	Then I should not see deleted developer

  Scenario: Visitor can not see deleted developer
    Given I am not signed in
	And I have a deleted developer
    When I am on the developers overview page
	Then I should not see deleted developer
	
  Scenario: Visitor can not show deleted developer
    Given I am not signed in
    And I am on the developers overview page
	And I have a deleted developer 
	When I enter the developer detail page
	Then I should be on the home page
	
  Scenario: User can not see deleted company
    Given I am signed in as User
	And I have a deleted company
    When I am on the companies overview page
	Then I should not see deleted company

  Scenario: Visitor can not see deleted company
    Given I am not signed in
	And I have a deleted company
    When I am on the companies overview page
	Then I should not see deleted company
	
  Scenario: Visitor can not show deleted company
    Given I am not signed in
    And I am on the companies overview page
	And I have a deleted company 
	When I enter the company detail page
	Then I should be on the home page
	

	

  Scenario: User can not edit locked company
    Given I am signed in as User
	And I have a locked company
	And I am on the detail page of the given company
	When I enter the company edit page
    Then I should be on the detail page of the given company
	
  Scenario: Visitor can not show blocked company
    Given I am not signed in
    And I am on the companies overview page
	And I have a blocked company 
	When I enter the company detail page
	Then I should be on the home page
	