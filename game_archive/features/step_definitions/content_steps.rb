When /^I create a developer with (.+)$/ do |fill|
  name = "Bob"
  fill_in("developer_name", :with => name)

  if fill == "a heading"
    @text = "Heading 1"
    markup_text = "# " + @text
  elsif fill == "a strong text"
    @text = "this is strong"
    markup_text = ("**" + @text + "**")
  elsif fill == "an emphasized text"
    @text = "this is emphasized"
    markup_text = ("*" + @text + "*")
  elsif fill == "an unordered list"
    @nr_elements = 3
    markup_text = "* element1\n* element2\n* element3"
  elsif fill == "html tags"
    @text = "Google"
    markup_text = "<a href='www.google.at'>" + @text + "</a>"
  elsif fill == "two paragraphs"
    @text1 = "paragraph 1"
    @text2 = "paragraph 2"
    @nr_paragraphs = 2
    markup_text = @text1 + "\n\n" + @text2
  end

  fill_in("developer_description", :with => (markup_text))
  click_button "Create Developer"

  @developer = Developer.find_by_name name
end

Then /^I should see the developer$/ do
  page.should have_content(@developer.name)
end

Then /^I should see the heading$/ do
  page.should have_selector(".developer .text h1")
  find(".developer").find(".text").find("h1").should have_content(@text)
end

Then /^I should see the strong text$/ do
  page.should have_selector(".developer .text strong")
  find(".developer").find(".text").find("strong").should have_content(@text)
end

Then /^I should see the emphasized text$/ do
  page.should have_selector(".developer .text em")
  find(".developer").find(".text").find("em").should have_content(@text)
end

Then /^I should see the unordered list$/ do
  page.should have_selector(".developer .text ul")
  within(".text ul") do
    counter = 0
    all('li').each { |el| counter = counter + 1}
    counter.should == @nr_elements
  end
end

Then /^I should see the html written in text$/ do
  page.should_not have_selector(".developer .text a")
  page.should have_content(@text)
end

When /^I try using heading markdown in the name field$/ do
  @name = "# BobHeading"
  fill_in("developer_name", :with => @name)
  click_button "Create Developer"

  @developer = Developer.find_by_name @name
end

Then /^I should see the syntax for heading as the name$/ do
  page.should have_content(@name)
  @name.should == @developer.name
end

Then /^I should see the two paragraphs$/ do
  within(".developer .text") do
    counter = 0
    all('p').each { |el| counter = counter + 1}
    counter.should == @nr_paragraphs
  end
end

When /^I create a game with (.+)$/ do |fill|
  title = "GameABC"
  fill_in("game_title", :with => title)

  if fill == "a long link without a name"
    markup_text = 'http://46.163.119.27:8086/secure/RapidBoard.jspa?rapidView=1&view=detail&selectedIssue=GA-35'
  elsif fill == "a short link without a name"
    markup_text = 'http://www.google.com/'
  elsif fill == "a link with a name"
    markup_text = '[Google](http://www.google.com/)'
  end

  fill_in("game_description", :with => markup_text)
  click_link_or_button "Create Game"

  @game = Game.find_by_title title
end

Then /^I should see the game$/ do
  page.should have_content(@game.title)
end

Then /^I should see a short link without protocol and trailing backspace$/ do
  page.should have_selector(".game .text a")
  link_val = find(".game .text a").text
  assert (not link_val.start_with?("http://"))
  assert (not link_val.end_with?("/"))
end

Then /^I should see a long link shortened without protocol$/ do
  page.should have_selector(".game .text a")
  link_val = find(".game .text a").text
  assert (not link_val.start_with?("http://"))
  assert (link_val.end_with?("..."))
  assert (link_val.length <= 30)
end

Then /^I should see the link as a name$/ do
  page.should have_selector(".game .text a")
  link = find(".game .text a")
  assert (link.text == "Google")
  assert (link['href'] == "http://www.google.com/")
end

# landingpage steps
Given /^I have a selection of games$/ do
	@game1=FactoryGirl.create :game , title:"Game 1"
	@game1.popularity = 1
	@game2=FactoryGirl.create :game , title:"Game 2"
	@game2.popularity = 2
	@game3=FactoryGirl.create :game , title:"Game 3"
	@game3.popularity = 4
	@game4=FactoryGirl.create :game , title:"Game 4"
	@game4.popularity = 5
	@game5=FactoryGirl.create :game , title:"Game 5"
	@game5.popularity = 6
	@game6=FactoryGirl.create :game , title:"Game 6"
	@game6.popularity = 2
end

Given /^I have a selection of developers$/ do
	@dev1=FactoryGirl.create :developer , name:"Developer 1"
	@dev1.popularity = 1
	@dev2=FactoryGirl.create :developer , name:"Developer 2"
	@dev2.popularity = 2
	@dev3=FactoryGirl.create :developer , name:"Developer 3"
	@dev3.popularity = 4
	@dev4=FactoryGirl.create :developer , name:"Developer 4"
	@dev4.popularity = 5
	@dev5=FactoryGirl.create :developer , name:"Developer 5"
	@dev5.popularity = 6
	@dev6=FactoryGirl.create :developer , name:"Developer 6"
	@dev6.popularity = 2
end

Given /^I have a selection of companies$/ do
	@com1=FactoryGirl.create :company , name:"Company 1"
	@com1.popularity = 1
	@com2=FactoryGirl.create :company , name:"Company 2"
	@com2.popularity = 2
	@com3=FactoryGirl.create :company , name:"Company 3"
	@com3.popularity = 4
	@com4=FactoryGirl.create :company , name:"Company 4"
	@com4.popularity = 5
	@com5=FactoryGirl.create :company , name:"Company 5"
	@com5.popularity = 6
	@com6=FactoryGirl.create :company , name:"Company 6"
	@com6.popularity = 2
end

When /^I am on the Home Page$/ do
	visit "/"
end

Then /^I should see a selection of games sorted by Newest$/ do
	within 'div.games_newest' do
		#page.should have_no_content(@game1.title)
		page.should have_content(@game2.title)
		page.should have_content(@game3.title)
		page.should have_content(@game4.title)
		page.should have_content(@game5.title)
		page.should have_content(@game6.title)
	end
	
end

Then /^I should see a selection of developers sorted by Newest$/ do
	within 'div.developers_newest' do
		#page.should have_no_content(@dev1.name)
		page.should have_content(@dev2.name)
		page.should have_content(@dev3.name)
		page.should have_content(@dev4.name)
		page.should have_content(@dev5.name)
		page.should have_content(@dev6.name)
	end
end

Then /^I should see a selection of companies sorted by Newest$/ do
	within 'div.companies_newest' do
		#page.should have_no_content(@com1.name)
		page.should have_content(@com2.name)
		page.should have_content(@com3.name)
		page.should have_content(@com4.name)
		page.should have_content(@com5.name)
		page.should have_content(@com6.name)
	end
end

Then /^I should see a selection of games sorted by Most Popular$/ do
	within 'div.games_most_popular' do
		#page.should have_no_content(@game1.title)
		page.should have_content(@game2.title)
		page.should have_content(@game3.title)
		page.should have_content(@game4.title)
		page.should have_content(@game5.title)
		page.should have_content(@game6.title)
	end
end

Then /^I should see a selection of developers sorted by Most Popular$/ do
	within 'div.developers_most_popular' do
		#page.should have_no_content(@dev1.name)
		page.should have_content(@dev2.name)
		page.should have_content(@dev3.name)
		page.should have_content(@dev4.name)
		page.should have_content(@dev5.name)
		page.should have_content(@dev6.name)
	end
end

Then /^I should see a selection of companies sorted by Most Popular$/ do
	within 'div.companies_most_popular' do
		#page.should have_no_content(@com1.name)
		page.should have_content(@com2.name)
		page.should have_content(@com3.name)
		page.should have_content(@com4.name)
		page.should have_content(@com5.name)
		page.should have_content(@com6.name)
	end
end

Then /^I should see a random game pick$/ do
	within 'div.games_random' do
		page.should have_content("Game")
	end
end

Then /^I should see a random developer pick$/ do
	within 'div.developers_random' do
		page.should have_content("Developer")
	end
end

Then /^I should see a random company pick$/ do
	within 'div.companies_random' do
		page.should have_content("Company")
	end
end

When /^I am on the Games Overview Page$/ do
	visit "/games/"
end