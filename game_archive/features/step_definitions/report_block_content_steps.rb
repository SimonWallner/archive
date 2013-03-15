Given /^I have a blocked (.+)$/ do |content|

  if content == "game"
	@givenGame=FactoryGirl.create :game , title: "Tetris"
	content_type = 0
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenGame.id
  elsif content == "developer"
	@givenDeveloper=FactoryGirl.create :developer, name: "Leela"
    content_type = 1
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenDeveloper.id
  elsif content == "company"
	@givenCompany=FactoryGirl.create :company, name: "Leela"
    content_type = 2
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenCompany.id
  end
end

Given /^I have a locked (.+)$/ do |content|

  if content == "game"
	@givenGame=FactoryGirl.create :game , title: "Tetris"
	content_type = 0
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenGame.id
  elsif content == "developer"
	@givenDeveloper=FactoryGirl.create :developer, name: "Leela"
    content_type = 1
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenDeveloper.id
  elsif content == "company"
	@givenCompany=FactoryGirl.create :company, name: "Leela"
    content_type = 2
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenCompany.id
  end
end

Given /^I have a deleted (.+)$/ do |content|

  if content == "game"
	@givenGame=FactoryGirl.create :game , title: "Tetris"
	content_type = 0
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:4, content_id:@givenGame.id
  elsif content == "developer"
	@givenDeveloper=FactoryGirl.create :developer, name: "Leela"
    content_type = 1
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:4, content_id:@givenDeveloper.id
  elsif content == "company"
	@givenCompany=FactoryGirl.create :company, name: "Leela"
    content_type = 2
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:4, content_id:@givenCompany.id
  end
end

Given /^I am on the report content page$/ do
  visit report_game_path(@givenGame)
end

When /^I follow the report content link$/ do
    click_link_or_button "Report"
end

When /^I press the (.*) button in Report page$/ do |blockedorlocked|
	click_link_or_button blockedorlocked
end

When /^I fill a reason$/ do
	fill_in "reportblockcontent_reason", :with => 'test'
end

When /^I select (.*) and submit it$/ do |blockedorlocked|
	if blockedorlocked =="Block"
		choose ("reportblockcontent_status_1") 
	else
		choose ("reportblockcontent_status_2") 
	end
	click_link_or_button "Save"
end

When /^I fill in the report and submit it$/ do
	@reportReason = "Reporting Reason xXMCm3Zb9Y"
	@reporterEmail = "FP25aoyQ3T@example.com"
	
	fill_in("report_reason", :with => @reportReason)
	fill_in("report_email", :with => @reporterEmail)
	click_button "Send Report"
end


When /^I fill in the fields of (.*) deletecontent with valid details and submit it$/ do |type|
  @report_reason="Reason"

  fill_in("reportblockcontent_reason", :with => @report_reason)
  click_button "Delete " + type
end

When /^I enter the (.*) edit page$/ do |type|
  if type == 'game'
	visit edit_game_path(@givenGame)
  elsif type == 'developer'
    visit edit_developer_path(@givenDeveloper)
  else
    visit edit_company_path(@givenCompany)
  end
end

When /^I enter the (.*) detail page$/ do |type|
  if type == 'game'
	visit game_path(@givenGame)
  elsif type == 'developer'
	visit developer_path(@givenDeveloper)
  else
	visit company_path(@givenCompany)
  end 
end

When /^I report the game$/ do
	visit '/games/1/'
	URI.parse(current_url).path.should == "/games/1/"
	click_link_or_button 'Report'
	@report_reason="Reason"
	@report_email="test@example.com"
    fill_in("reportblockcontent_reason", :with => @report_reason)
	fill_in("reportblockcontent_email", :with => @report_email)
	click_link_or_button 'Report Game'
end

When /^I lock the game$/ do
	visit_game_page @givenGame
	URI.parse(current_url).path.should == "/games/1"
	click_link_or_button "Block"
	@report_reason="Reason"
    fill_in("reportblockcontent_reason", :with => @report_reason)
	choose ("reportblockcontent_status_2")
	click_link_or_button "Save"
end

When /^I block the game$/ do
	visit_game_page @givenGame
	URI.parse(current_url).path.should == "/games/1"
	click_link_or_button "Block"
	@report_reason="Reason"
    fill_in("reportblockcontent_reason", :with => @report_reason)
	choose ("reportblockcontent_status_1")
	click_link_or_button "Save"
end

When /^I unblock the game$/ do
	visit_game_page @givenGame
	URI.parse(current_url).path.should == "/games/1"
	click_link_or_button "Remove Block"
	click_link_or_button "Remove Block"
end

Then /^there should be an email sent to the admin with valid information$/ do
	@newEmail = User.find_by_admin(true)
	mail_sent? :to => @newEmail, :subject => "Report content notification"
end

Then /^there should not be an email sent to the admin$/ do
	@newEmail = User.find_by_admin(true)
	not mail_sent? :to => @newEmail, :subject => "Report content notification"
end

Then /^I should not see deleted (.*)$/ do |type|
    if type == 'game'
		page.should_not have_content(@givenGame)
	elsif type == 'developer'
		page.should_not have_content(@givenDeveloper)
	else
		page.should_not have_content(@givenCompany)
	end 
end

Given /^there is an administrator admin$/ do
	create_admin_user({})
end





