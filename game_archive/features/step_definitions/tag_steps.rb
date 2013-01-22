Given /^I have tags named (.+)$/ do |names|
  @tags = Array.new
  names.split(', ').each do |t|
    FactoryGirl.create :tag, name: t
    @tags << t
  end
end

Given /^I have a tag named (.+)$/ do |name|
  @tag = FactoryGirl.create :tag, name: name
end

When /^I update the tag$/ do
  @newName = @tag.name + "new"
  fill_in("tag_name", :with => @newName)
  click_link_or_button "Update Tag"
end

Then /^I should see the new values of Tag$/ do
  page.should have_content(@newName)
end

Then /^I should see "(.+)" in the list of tags$/ do |tags|
    tags.split(', ').each do |tag|
       page.should have_content(tag)
    end
end

Then /^I should see the tags$/ do
  @tags.each do |g|
    page.should have_content(g)
  end
end

When /^I create a valid tag$/ do
  name = "Tag1"
  fill_in("tag_name", :with => name)
  click_link_or_button "Create Tag"

  @tag = Tag.find_by_name name
end

Then /^I should see the created tag$/ do
  page.should have_content(@tag.name)
end

When /^I write the tag named (.+)$/ do |name|
  fill_in("new_tags", :with => name)
end

Then /^I should not see the old tag$/ do
    page.should_not have_content(@tag)
end
