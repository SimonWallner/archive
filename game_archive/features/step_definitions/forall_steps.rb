
When /^I follow the new game link$/ do
  click_link_or_button "New Game"
end

When /^I follow the new developer link$/ do
  click_link_or_button "New Developer"
end

When /^I follow the new company link$/ do
  click_link_or_button "Create a New Studio or Organisation Article..."
end


When /^I fill in the fields with valid details for a (.+)$/ do |type|

  fill_in_name(type)

end

When /^I submit it$/ do

  submit_any_button

end