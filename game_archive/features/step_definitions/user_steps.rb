Given /^I am not signed in$/ do
  visit('/users/sign_out')
end

Given /^I am signed in as (.+)$/ do |role|

  email = 'user@user.com'
  @pwd = 'aA1aaaaaa'
  @user = User.create!(:email => email, :password => @pwd, :password_confirmation => @pwd)

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

Given /^I am invited$/ do
  @user = User.invite!(:email => "valid@email.com")
end

Given /^I am already registered$/ do
  @user.accept_invitation!
end

Given /^I am not invited$/ do
  @user = User.new
end

When /^I go to the sign up form$/ do
  visit accept_user_invitation_path(:invitation_token => @user.invitation_token)
end

When /^I enter and repeat a password$/ do
  newpassword = "bB2bbbbbb"
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
end

When /^I click on the sign up button$/ do
  click_link_or_button "Set my password"
end

Then /^I should be on the sign up page$/ do
  assert_equal current_path, accept_user_invitation_path

Given /^I am on the login page$/ do
  visit "/users/sign_in"
end

def reset_password(user)
  visit "/users/password/new"

  fill_in "user_email", :with => user.email
  click_link_or_button "Send me reset password instructions"
  URI.parse(current_url).path.should == "/users/sign_in"
  user.reset_password_token.should_not == nil
end

def have_received_pwd_reset(user)
  mail = ActionMailer::Base.deliveries.last
  mail['to'].to_s.should == user.email
  mail['subject'].to_s.should == "Reset password instructions"
end

When /^I reset my password$/ do
  reset_password @user
end

Given /^I have a user$/ do
  @user = FactoryGirl.create :user
end

Then /^I should receive an email with password reset instructions$/ do
  have_received_pwd_reset @user
end

Given /^I have received a password reset email$/ do
  reset_password @user
  have_received_pwd_reset @user
end

When /^I follow the reset link$/ do
  link = ("/users/password/edit?reset_password_token=" + @user.reset_password_token)
  visit link
end

When /^I set my new password$/ do
  fill_in "user_password", :with => "aA1aaaa"
  fill_in "user_password_confirmation", :with => "aA1aaaa"
  click_link_or_button "Change my password"
end

Then /^I am signed in$/ do
  assert user_signed_in?
  current_user.should == @user
end

Then /^I am on the home page$/ do
  URI.parse(current_url).path.should == "/"
end