Given /^I have developers named (.+)$/ do |names|
    names.split(', ').each do |name|
        FactoryGirl.create :developer , name:name
    end
end
Given /^I have a developer named "(.+)"$/ do |name|
        FactoryGirl.create :developer , name:name
end



When /^I go to the (.+) page$/ do |pagetitle|
    if pagetitle == "home"
        visit "/"
    else
        visit "/#{pagetitle}"
    end
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

#Then /^I click button "(.+)"$/ do |btn|
#    click_link_or_button(btn)
#end

