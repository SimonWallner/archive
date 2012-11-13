Feature: Structure Content
	In order to structure the content
	As a contributor
	I want to use simplified markup ("markdown") for general text
	
	Scenario: create title
        Given I am on the home page
        When I open the people page
        And I open the new developer page
		And I fill in the name with "New Developer"
		And I fill in the description with "## H2 Title"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Developer"
		And I should see "H2 Title" as <h2> title
		
	Scenario: strong text
        Given I am on the home page
        When I open the people page
        And I open the new developer page
		And I fill in the name with "New Developer"
		And I fill in the description with "**emphasized**"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Developer"
		And the description should have <strong>emphasized</strong>
		
	Scenario: emphasize text
        Given I am on the home page
        When I open the people page
        And I open the new developer page
		And I fill in the name with "New Developer"
		And I fill in the description with "*emphasized*"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Developer"
		And the description should have <em>emphasized</em>
		
	Scenario: ordered list
        Given I am on the home page
        When I open the games page
        And I open the new game page
		And I fill in the title with "New Game"
		And I fill in the description with "1. item1 \n 2. item2"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Game"
		And the description should have an <ol> with items <li>item1</li> and <li>item2</li>
		
	Scenario: unordered list
        Given I am on the home page
        When I open the people page
        And I open the new developer page
		And I fill in the name with "New Developer"
		And I fill in the description with "- item1 \n - item2"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Developer"
		And the description should have an <ul> with items <li>item1</li> and <li>item2</li>
		
	Scenario: filter html
		Given I am on the home page
        When I open the developers page
        And I open the new developer page
		And I fill in the name with "New Developer"
		And I fill in the description with "<h2>H2 Title</h2><p />text"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "New Developer"
		And I should see "<h2>H2 Title</h2><p />text" as normal text
		
	Scenario: filter in text fields
		Given I am on the home page
        When I open the developers page
        And I open the new developer page
		And I fill in the name with "# New Developer"
		And I fill in the description with "text"
		And I click on the create developer button
		Then I should see a confirmation
		And I should see "# New Developer" as name
		
	Scenario: create paragraph
		Given I am on the home page
        When I open the games page
        And I open the new game page
		And I fill in the title with "New Game"
		And I fill in the description with "p1" + two line breaks + "p2"
		And I click on the create game button
		Then I should see a confirmation
		And I should see "New Game"
		And I should see "p1" and "p2" separated by one blank line
		
	