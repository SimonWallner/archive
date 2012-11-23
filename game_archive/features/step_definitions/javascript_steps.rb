And /^I input "(.+)" in the (.+) field$/ do |str,fname|
  page.execute_script %Q{ $('##{fname}').val($('##{fname}').val()+'#{str}').keydown() }
  sleep(2)
end

And /^I clear the (.+) field$/ do |fname|
  page.execute_script %Q{ $('##{fname}').val('').keydown() }
end

Then /^I should have a link to (.*)$/ do |str|
  page.should have_content(str)
end

Then /^I should have genre "(.*)" added$/ do |str|
  page.should have_field('new_genres', :with => str)
end

Then /^I click the autocomplete for "(.*)"$/ do |str|
  page.execute_script %Q{ $('.ui-menu-item a:contains(#{str})').trigger('mouseenter').click(); }
  sleep(1)
end

And /^I submit the game update$/ do
  click_button "Update Game"
end