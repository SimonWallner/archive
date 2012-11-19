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