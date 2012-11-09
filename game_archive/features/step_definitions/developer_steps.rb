
Given /^I have developers titled (.+)$/ do |titels|
    titels.split(', ').each do |titel|
        FactoryGirl.create :developer , titel:titel
    end
end

When /^I go to the developers page$/ do
    visit '/developers'
end

#Then /^I should see "(.*?)"$/ do |developername|
#    page.should have_content(developername)
#end

Given /^I have a developer "(.*?)" with the description "(.*?)"$/ do |developer, content|
    FactoryGirl.create :developer, titel:developer , content:content
end

#Then /^I click "(.*?)"$/ do |titel|
#    developer = Developer.find_by_titel titel
#    visit "/developers/#{developer.id}"
#end

Then /^I click button (.+)$/ do |btn|
    find_button(btn).click
end

