
Given /^I have developers titled (.+)$/ do |names|
    names.split(', ').each do |name|
        FactoryGirl.create :developer , name:name
    end
end

When /^I go to the developers page$/ do
    visit '/developers'
end

#Then /^I should see "(.*?)"$/ do |developername|
#    page.should have_content(developername)
#end

Given /^I have a developer "(.*?)" with the description "(.*?)"$/ do |developer, content|
    FactoryGirl.create :developer, name:developer , description:content
end

#Then /^I click "(.*?)"$/ do |titel|
#    developer = Developer.find_by_titel titel
#    visit "/developers/#{developer.id}"
#end

Then /^I click button (.+)$/ do |btn|
    find_button(btn).click
end

