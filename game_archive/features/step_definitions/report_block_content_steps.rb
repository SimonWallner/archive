Given /^I have a blocked (.+)$/ do |content|

  if content == "game"
	@givenGame=FactoryGirl.create :game , title: "Tetris"
	content_type = 0
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenGame.id
  else if content == "developer"
	@givenDeveloper=FactoryGirl.create :developer, name: "Leela"
    content_type = 1
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenDeveloper.id
  else if content == "company"
	@givenCompany=FactoryGirl.create :company, name: "Leela"
    content_type = 2
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:1, content_id:@givenCompany.id
  end
  end
  end
end

Given /^I have a locked (.+)$/ do |content|

  if content == "game"
	@givenGame=FactoryGirl.create :game , title: "Tetris"
	content_type = 0
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenGame.id
  else if content == "developer"
	@givenDeveloper=FactoryGirl.create :developer, name: "Leela"
    content_type = 1
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenDeveloper.id
  else if content == "company"
	@givenCompany=FactoryGirl.create :company, name: "Leela"
    content_type = 2
	  @givenReportblockcontent=FactoryGirl.create :reportblockcontent, content_type:content_type ,status:2, content_id:@givenCompany.id
  end
  end
  end
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




