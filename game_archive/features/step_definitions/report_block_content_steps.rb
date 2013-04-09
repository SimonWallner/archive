Given /^I am on the report content page$/ do
	if (@givenGame)
		visit report_game_path(@givenGame)
	elsif (@givenCompany)
		visit report_company_path(@givenCompany)
	elsif (@givenDeveloper)
		visit report_developer_path(@givenDeveloper)
	end
end

When /^I follow the report content link$/ do
    click_link_or_button "Report"
end

When /^I fill in the report and submit it$/ do
	@reportReason = "Reporting Reason xXMCm3Zb9Y"
	@reporterEmail = "FP25aoyQ3T@example.com"
	
	fill_in("report_reason", :with => @reportReason)
	fill_in("report_email", :with => @reporterEmail)
	click_button "Send Report"
end

Then /^there should be an email sent to the admin with valid information$/ do
	@newEmail = User.find_by_admin(true)
	mail_sent? :to => @newEmail, :subject => "Report content notification"
end

Then /^there should not be an email sent to the admin$/ do
	@newEmail = User.find_by_admin(true)
	not mail_sent? :to => @newEmail, :subject => "Report content notification"
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

Then /^The developer should be reported$/ do
  	contentType = Reportblockcontent::DEVELOPER
  	reportblockcontent = Reportblockcontent.find_by_content_type_and_content_id(contentType, @givenDeveloper.id)
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

Given /^I have a few reports for developers$/ do
	@givenDevelopers = Array.new
	@reports = Array.new
	content_type = Reportblockcontent::DEVELOPER
	status = Reportblockcontent::REPORTED
	
	for i in 1..5.to_i
  		developer = FactoryGirl.create :developer,
			name: "random name: #{SecureRandom.uuid.to_s}",
			version_id: "someVersionID", version_number: i
		@givenDevelopers.push(developer)
		
		@reports.push(FactoryGirl.create :reportblockcontent,
			content_type: content_type, status: status, content_id: developer.id,
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
	@deletedReport = @reports[2]
	click_on "delete-#{@deletedReport.id}"
end

Then /^that report should be deleted$/ do
	expect{Reportblockcontent.find(@deletedReport.id)}.to raise_error
	
	@reports.each do |rep|
		if (rep != @deletedReport)
			Reportblockcontent.find(rep.id).should_not be_nil
		end
	end
end

When /^I report that article$/ do
	# make sure only one is defined!
	if ((@givenGame && @givenCompany) || (@givenCompany && @givenDeveloper) || (@givenDeveloper && @givenGame))
		fail "more than one of [game, company, developer] defined D:"
	end
	
	if (@givenGame)
		visit game_path(@givenGame)
	elsif (@givenCompany)
		visit company_path(@givenCompany)
	elsif (@givenDeveloper)
		visit developer_path(@givenDeveloper)
	end
		
    click_link_or_button "Report"

	@reportReason = "Reporting Reason 0kOJ9DQOOvGX7JnXHVRD"
	@reporterEmail = "TWxZsHG1EFvHaOhe2PIL@example.com"

	fill_in("report_reason", :with => @reportReason)
	fill_in("report_email", :with => @reporterEmail)
	click_button "Send Report"
end

Then /^an email with the report should be sent to all administrators$/ do
	for admin in @admins do
		unread_emails_for(admin.email).size.should == 1
		open_email(admin.email)
		current_email.subject.should eql "[Archive] New Content Report!"
		current_email.body.should have_content "Hello #{admin.firstname}"

		if (@givenGame)
			current_email.body.should have_content @givenGame.title
		elsif (@givenCompany)
			current_email.body.should have_content @givenCompany.name
		elsif (@givenDeveloper)
			current_email.body.should have_content @givenDeveloper.name
		end

		current_email.body.should have_content @reportReason
		current_email.body.should have_content @reportEmail
	end
end



