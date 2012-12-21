Given /^I have a (.*) game$/ do |blockedorlocked|
  @givenGame=FactoryGirl.create :game , title: "Tetris"
  if blockedorlocked == "blocked"
	status = 1
  else if blockedorlocked == "locked"
    status = 2
  end
  end
  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:0 ,status:status, content_id:@givenGame.id
end

Given /^I have a (.*) developer$/ do |blockedorlocked|
  @givenDeveloper=FactoryGirl.create :developer, name: "Leela"
  if blockedorlocked == "blocked"
	status = 1
  else 
    status = 2
  end
  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:1 ,status:status, content_id:@givenDeveloper.id
end

Given /^I have a (.*) company$/ do |blockedorlocked|
  @givenCompany=FactoryGirl.create :company, name: "Leela"
  if blockedorlocked == "blocked"
	status = 1
  else 
    status = 2
  end
  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:2 ,status:status, content_id:@givenCompany.id
end

When /^I follow the (.*) content link$/ do |button|
    click_link_or_button button
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

When /^I fill in the fields of (.*) reportblockcontent with valid details and submit it$/ do |type|
  @report_reason="Reason"
  @reporter_email= "email@email.com"

  fill_in("reportblockcontent_reason", :with => @report_reason)
  fill_in("reportblockcontent_reason", :with => @reporter_email)
  click_button "Report " + type
end

When /^I enter the (.*) edit page$/ do |type|
  if type == 'game'
	visit edit_game_path(@givenGame)
  else if type == 'developer'
    visit edit_developer_path(@givenDeveloper)
  else
    visit edit_company_path(@givenCompany)
  end 
  end
end

When /^I enter the (.*) detail page$/ do |type|
  if type == 'game'
	visit game_path(@givenGame)
  else if type == 'developer'
	visit developer_path(@givenDeveloper)
  else
	visit company_path(@givenCompany)
  end 
  end 
end





