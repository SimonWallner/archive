Given /^I am on the report content page$/ do
	if (@givenGame)
		visit report_game_path(@givenGame)
	elsif (@givenCompany)
		visit report_company_path(@givenCompany)
	end
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

Then /^I should be on the game article page$/ do
  	URI.parse(current_url).path.should == game_path(@givenGame)
end

Then /^I should see a thank you notice$/ do
  page.should have_content("Thank you")
end

Then /^I should see an access denied notice$/ do
  page.should have_content("Access Denied!")
end

Then /^The game should be reported$/ do
	contentType = Reportblockcontent::GAME
  	reportblockcontent = Reportblockcontent.find_by_content_type_and_content_id(contentType, @givenGame.id)
	reportblockcontent.should_not be_nil
	reportblockcontent.reason.should eql(@reportReason)
	reportblockcontent.email.should eql(@reporterEmail)
end

Then /^The company should be reported$/ do
  	contentType = Reportblockcontent::COMPANY
  	reportblockcontent = Reportblockcontent.find_by_content_type_and_content_id(contentType, @givenCompany.id)
	reportblockcontent.should_not be_nil
	reportblockcontent.reason.should eql(@reportReason)
	reportblockcontent.email.should eql(@reporterEmail)
end

Given /^I have a few reports for games$/ do
	@givenGames = Array.new
	@reports = Array.new
	content_type = Reportblockcontent::GAME
	status = Reportblockcontent::REPORTED
	
	for i in 1..5.to_i
  		game = FactoryGirl.create :game,
			title: "random title: #{SecureRandom.uuid.to_s}",
			version_id: "someVersionID", version_number: i
		@givenGames.push(game)
		
		@reports.push(FactoryGirl.create :reportblockcontent,
			content_type: content_type, status: status, content_id: game.id,
			reason: "random reason: #{SecureRandom.uuid.to_s}",
			email: "#{SecureRandom.uuid.to_s}@example.com")
	end
end

Given /^I have a few reports for companies$/ do
	@givenCompanies = Array.new
	@reports = Array.new
	content_type = Reportblockcontent::COMPANY
	status = Reportblockcontent::REPORTED
	
	for i in 1..5.to_i
  		company = FactoryGirl.create :company,
			name: "random name: #{SecureRandom.uuid.to_s}",
			version_id: "someVersionID", version_number: i
		@givenCompanies.push(company)
		
		@reports.push(FactoryGirl.create :reportblockcontent,
			content_type: content_type, status: status, content_id: company.id,
			reason: "random reason: #{SecureRandom.uuid.to_s}",
			email: "#{SecureRandom.uuid.to_s}@example.com")
	end
end

When /^I visit the admin's report section$/ do
	visit reportblockcontents_path
end

Given /^I am in the admin's report section$/ do
  visit reportblockcontents_path
end

Then /^I should see the reports with their details$/ do
	if (@givenGames)
		@givenGames.each do |game|
			page.should have_content(game.title)
		end
	elsif (@givenCompanies)
		@givenCompanies.each do |com|
			page.should have_content(com.name)
		end
	end	
		
	@reports.each do |report|
		page.should have_content(report.reason)
		page.should have_link('Email', :href => "mailto:#{report.email}")
	end
end

Then /^I should be redirected to the landing page$/ do
	URI.parse(current_url).path.should == root_path
end

When /^I delete on of these reports$/ do
	@report = @reports[2]

	# make the delete link a button maybe?
	# otherwise have to us js text :(
	click_on "delete-#{@report.id}"
	
end

Then /^that report should be deleted$/ do
	expect{Reportblockcontent.find(@report.id)}.to raise_error
	
	@reports.each do |rep|
		if (rep != @report)
			Reportblockcontent.find(rep.id).should_not be_nil
		end
	end
end

