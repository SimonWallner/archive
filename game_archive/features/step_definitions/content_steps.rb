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