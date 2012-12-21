Feature: Lock Page /Block Content
  As an administrator,
  in order to conquer inappropriate content and to react to vandalism quickly,
  I want to lock and block content

  Scenario: Admin block game's page with valid data
    Given I am signed in as Admin
	And I have a game Tetris
    And I am on the detail page of the game
    When I follow the Block content link
	And I fill a reason  
	And I select Block and submit it
    Then I should be on the detail page of the given game

  Scenario: Admin lock game's page with valid data
    Given I am signed in as Admin
	And I have a game Tetris
    And I am on the detail page of the game
    When I follow the Block content link
	And I fill a reason  
	And I select Lock and submit it
    Then I should be on the detail page of the given game
	
  Scenario: Admin remove block game's page with valid data
    Given I am signed in as Admin
	And I have a blocked game
	And I am on the detail page of the game
    When I follow the Remove Block content link
	And I press the Remove Block button in Report page
    Then I should be on the detail page of the given game

  Scenario: Admin remove lock game's page with valid data
    Given I am signed in as Admin
	And I have a locked game
	And I am on the detail page of the game
    When I follow the Remove Lock content link
	And I press the Remove Lock button in Report page
    Then I should be on the detail page of the given game
	
  Scenario: Admin block developer's page with valid data
    Given I am signed in as Admin
	And I have a developer Leela
	And I am on the detail page of the given developer
    When I follow the Block content link
	And I fill a reason  
	And I select Block and submit it
    Then I should be on the detail page of the given developer

  Scenario: Admin lock developer's page with valid data
    Given I am signed in as Admin
	And I have a developer Leela
	And I am on the detail page of the given developer
    When I follow the Block content link
	And I fill a reason  
	And I select Lock and submit it
    Then I should be on the detail page of the given developer
	
  Scenario: Admin remove block developer's page with valid data
    Given I am signed in as Admin
	And I have a blocked developer
	And I am on the detail page of the given developer
    When I follow the Remove Block content link
	And I press the Remove Block button in Report page
    Then I should be on the detail page of the given developer

  Scenario: Admin remove lock developer's page with valid data
    Given I am signed in as Admin
	And I have a locked developer
	And I am on the detail page of the given developer
    When I follow the Remove Lock content link
	And I press the Remove Lock button in Report page
    Then I should be on the detail page of the given developer
	
  Scenario: Admin block company's page with valid data
    Given I am signed in as Admin
	And I have a company Leela
	And I am on the detail page of the given company
    When I follow the Block content link
	And I fill a reason  
	And I select Block and submit it
    Then I should be on the detail page of the given company


  Scenario: Admin lock company's page with valid data
    Given I am signed in as Admin
	And I have a company Tetris
	And I am on the detail page of the given company
    When I follow the Block content link
	And I fill a reason  
	And I select Lock and submit it
    Then I should be on the detail page of the given company

	
  Scenario: Admin remove block company's page with valid data
    Given I am signed in as Admin
	And I have a blocked company
	And I am on the detail page of the given company
    When I follow the Remove Block content link
	And I press the Remove Block button in Report page
    Then I should be on the detail page of the given company


  Scenario: Admin remove lock company's page with valid data
    Given I am signed in as Admin
	And I have a locked company
	And I am on the detail page of the given company
    When I follow the Remove Lock content link
	And I press the Remove Lock button in Report page
    Then I should be on the detail page of the given company
	
  Scenario: User can not edit locked game
    Given I am signed in as User
	And I have a locked game
	And I am on the detail page of the game
	When I enter the game edit page
    Then I should be on the detail page of the given game
	
  Scenario: Visitor can not show blocked game
    Given I am not signed in
    And I am on the games overview page
	And I have a blocked game 
	When I enter the game detail page
	Then I should be on the home page
	
  Scenario: User can not edit locked developer
    Given I am signed in as User
	And I have a locked developer
	And I am on the detail page of the given developer
	When I enter the developer edit page
    Then I should be on the detail page of the given developer
	
  Scenario: Visitor can not show blocked developer
    Given I am not signed in
    And I am on the developers overview page
	And I have a blocked developer 
	When I enter the developer detail page
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
	