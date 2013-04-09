Feature: administrate reported content
	As a site administrator,
	in order to react quickly to reported content,
	I want to receive email notifications on reports.
	
	Scenario Outline: Send notification to all administrators when a new report comes in
		Given there are a few administrators
		And I have a <kind>
		And no emails have been sent
		When I report that article
		Then an email with the report should be sent to all administrators
		
		Examples:
		 | kind                |
		 | game Tetris         |
		 | company AwesomeCorp |
		 | developer Jane Doe  |

