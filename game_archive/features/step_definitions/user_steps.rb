Given /^I am not signed in$/ do
  visit('/users/sign_out')
end

Given /^I am signed in as (.+)$/ do |role|

  email = 'user@user.com'
  @pwd = 'aA1aaaaaa'
  @user = User.new(:email => email, :password => @pwd, :password_confirmation => @pwd)
  @user.save!

  if role == 'Admin'
    @user.toggle :admin
  end

  visit '/users/sign_in'
  fill_in 'user_email', :with => email
  fill_in 'user_password', :with => @pwd
  click_link_or_button 'Sign in'
end

def go_to_edit_page
  visit "/users/edit"
end

When /^I enter edit user url$/ do
  go_to_edit_page
end

Then /^I should be redirected to the sign in page$/ do
  URI.parse(current_url).path.should == "/users/sign_in"
end

Given /^I am on the user edit page$/ do
  go_to_edit_page
end

When /^I change my data$/ do
  newpassword = "bB2bbbbbb"
  @newDetails = FactoryGirl.build :user, email: "new@user.at", firstname: "newfirst", lastname: "newlast", password: newpassword

  fill_in "user_email", :with => @newDetails.email
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
  fill_in "user_firstname", :with => @newDetails.firstname
  fill_in "user_lastname", :with => @newDetails.lastname
end

When /^I provide the correct password$/ do
  fill_in "user_current_password", :with => @pwd
  click_link_or_button "Update"
end

Then /^I should be on the home page$/ do
  URI.parse(current_url).path.should == "/"
end

Then /^The data has been updated$/ do
  @user = User.find_by_email @newDetails.email
  @user.email.should == @newDetails.email
  @user.firstname.should == @newDetails.firstname
  @user.lastname.should == @newDetails.lastname
end

When /^I provide the wrong password$/ do
  fill_in "user_current_password", :with => (@pwd + "A")
  click_link_or_button "Update"
end

Then /^I should be on the user edit page$/ do
  page.should have_content("Edit User")
end

Then /^I should see an error$/ do
  error = find("#error_explanation")
  within(error) do
    page.should have_content("Current password is invalid")
  end
end