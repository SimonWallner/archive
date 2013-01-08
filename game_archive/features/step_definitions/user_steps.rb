Then /^I should be redirected to the sign in page$/ do
  URI.parse(current_url).path.should == "/users/sign_in"
end

When /^I change all my data$/ do
  newpassword = "bB2bbbbbb"
  @newDetails = FactoryGirl.build :confirmed_user, email: "new@user.at", firstname: "newfirst", lastname: "newlast", password: newpassword
  @newDetails.should_not == nil

  fill_in "user_email", :with => @newDetails.email
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
  fill_in "user_firstname", :with => @newDetails.firstname
  fill_in "user_lastname", :with => @newDetails.lastname
  @pwdSet = true
end

When /^I change a valid password$/ do
  newpassword = "bB2bbbb"
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
  @pwdSet = "valid"
end

When /^I change a too short password$/ do
  newpassword = "bbb"
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
  @pwdSet = "too_short"
end

When /^I change an invalid password$/ do
  newpassword = "12345678"
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
  @pwdSet = "invalid"
end

When /^I change all my data except my password$/ do
  @newDetails = FactoryGirl.build :confirmed_user, email: "new@user.at", firstname: "newfirst", lastname: "newlast", password: "not_nedded"
  @newDetails.should_not == nil

  fill_in "user_email", :with => @newDetails.email
  fill_in "user_firstname", :with => @newDetails.firstname
  fill_in "user_lastname", :with => @newDetails.lastname
  @pwdSet = false
end

def provide_correct_password
  fill_in "user_current_password", :with => @pwd
end

def update_form
  click_link_or_button "Update"
end

When /^I provide the correct password$/ do
  provide_correct_password
  update_form
end

Then /^I should be on the home page$/ do
  URI.parse(current_url).path.should == "/"
end

Then /^The data has been updated$/ do
  #save_and_open_page
  if @pwdSet == nil || @pwdSet == false
    @user.reload
    if @email_confirmed
      @user.email.should == @newDetails.email
    else
      @user.email.should == @email
      unless @email_confirmed == nil
        @user.unconfirmed_email.should = @newDetails.email
      end
    end
    @user.firstname.should == @newDetails.firstname
    @user.lastname.should == @newDetails.lastname
  end
end

When /^I provide the wrong password$/ do
  fill_in "user_current_password", :with => (@pwd + "A")
  update_form
end

Then /^I should see an error$/ do
  page.should have_selector("#error_explanation")
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

When /^I change my email$/ do
  @newEmail = "new@example.com"
  fill_in "user_email", :with => @newEmail
  provide_correct_password
  update_form
end

Then /^I should receive an email with confirmation instructions$/ do
  mail_sent? :to => @newEmail, :subject => "Confirmation instructions"
end

Then /^The email has not changed yet$/ do
  @user.email.should_not == @newEmail
  @user.email.should == @email
end

Then /^My email has been updated$/ do
  @user.email.should == @newEmail
end

When /^I enter and repeat a password$/ do
  newpassword = "bB2bbbbbb"
  fill_in "user_password", :with => newpassword
  fill_in "user_password_confirmation", :with => newpassword
end

When /^I click on the sign up button$/ do
  click_link_or_button "Set my password"
end

def reset_password
  visit_reset_password_page

  fill_in "user_email", :with => @user.email
  click_link_or_button "Send me reset password instructions"
  URI.parse(current_url).path.should == "/users/sign_in"
  @user = User.find_by_email @user.email
  @user.reset_password_token.should_not == nil
end

def have_received_pwd_reset
  mail_sent? :to => @user.email, :subject => "Reset password instructions"
end

When /^I reset my password$/ do
  reset_password
end

Then /^I should receive an email with password reset instructions$/ do
  have_received_pwd_reset
end

Given /^I have received a password reset email$/ do
  reset_password
  have_received_pwd_reset
end

When /^I sign up with a short password$/ do
  fill_in "user_password", :with => "aA1a"
  fill_in "user_password_confirmation", :with => "aA1a"
end

When /^I sign up with a weak password$/ do
  fill_in "user_password", :with => "aaaaaaaaaa"
  fill_in "user_password_confirmation", :with => "aaaaaaaaaa"
end

When /^I sign up with passwords not matching$/ do
  fill_in "user_password", :with => "aA1aaaaaa"
  fill_in "user_password_confirmation", :with => "aA1aaaaab"
end

Then /^I am signed in$/ do
  page.should have_content("Edit")
  page.should have_content("Logout")
end

Then /^No invitation should be sent$/ do
  assert (not User.exists?(:email => @email))
end

When /^I follow the send invite link$/ do
  click_link_or_button 'Invite Users'
end

When /^I enter a valid email$/ do
  @email = "new@new.at"
  fill_in "user_email", :with => @email
  click_link_or_button "Send an invitation"
end

When /^I enter an invalid email$/ do
  @email = "asf"
  fill_in "user_email", :with => @email
  click_link_or_button "Send an invitation"
end
When /^I enter an already used email$/ do
  @email = "new@new.at"
  FactoryGirl.create(:user, :email => @email)
  fill_in "user_email", :with => @email
  click_link_or_button "Send an invitation"
end

Then /^Invitation should be sent$/ do
  assert (User.exists?(:email => @email))
end

Then /^I should see an email already used error$/ do
  within("#error_explanation") do
    page.should have_content("Email has already been taken")
  end
end

When /^I enter my email$/ do
  fill_in "user_email", :with => @user.email
  click_link_or_button "Send me reset password instructions"
  URI.parse(current_url).path.should == "/users/sign_in"
  @user = User.find_by_email @user.email
  @user.reset_password_token.should_not == nil
end

When /^I enter an email which does not belong to a user$/ do
  fill_in "user_email", :with => "hadasdsad@example.com"
  click_link_or_button "Send me reset password instructions"
  URI.parse(current_url).path.should == "/users/password"
  @user = User.find_by_email @user.email
  @user.reset_password_token.should == nil
end

Then /^I should not see an error$/ do
  page.should_not have_selector("#error_explanation")
end

When /^I set a valid password$/ do
  fill_in "user_password", :with => "aA1aaaa"
  fill_in "user_password_confirmation", :with => "aA1aaaa"
  click_link_or_button "Change my password"
end

When /^I set an invalid password$/ do
  fill_in "user_password", :with => "abcefghij"
  fill_in "user_password_confirmation", :with => "abcefghij"
  click_link_or_button "Change my password"
end

When /^I set a too short password$/ do
  fill_in "user_password", :with => "aaa"
  fill_in "user_password_confirmation", :with => "aaa"
  click_link_or_button "Change my password"
end

When /^I leave the password blank$/ do
  fill_in "user_password", :with => ""
  fill_in "user_password_confirmation", :with => ""
  click_link_or_button "Change my password"
end

When /^I set a wrong confirmation password$/ do
  fill_in "user_password", :with => "aA1aaaa"
  fill_in "user_password_confirmation", :with => "aB1aaaa"
  click_link_or_button "Change my password"
end

Then /^I should be signed in$/ do
  page.should have_content("My Account")
  page.should have_content("Sign Out")
end

Then /^I should not be signed in$/ do
  page.should have_content("Sign In")
end

Then /^an invitation should be sent$/ do
  assert (User.exists?(:email => @email))
end

# Promote Admin Steps
Given /^I have a user who is admin$/ do
	email = 'test@user.com'
	@pwd = 'aA1aaaaaa'
	@firstname = 'test'
	@lastname = 'user'
	User.create!(:email => email, :password => @pwd, :password_confirmation => @pwd, :firstname => @firstname, :lastname => @lastname, :admin => true)
end

Given /^I have a user who is not admin$/ do
	email = 'test@user.com'
	@pwd = 'aA1aaaaaa'
	@firstname = 'test'
	@lastname = 'user'
	User.create!(:email => email, :password => @pwd, :password_confirmation => @pwd, :firstname => @firstname, :lastname => @lastname)
end

When /^I go to the promote admin page$/ do
	click_link_or_button "Manage Users"
end

When /^I enter a valid user email adress$/ do
	
	fill_in "email", :with => another_user_hash[:email]
end

When /^I enter a user email$/ do
	fill_in "email", :with => another_user_hash[:email]
end

When /^I enter an invalid email adress$/ do
	fill_in "email", :with => 'test@invalid.com'
end

When /^I enter an admin email$/ do
	fill_in "email", :with => another_user_hash[:email]
end

When /^I enter a valid full name$/ do
	fill_in "firstname", :with => another_user_hash[:firstname]
	fill_in "lastname", :with => another_user_hash[:lastname]
end

When /^I enter an invalid full name$/ do
	fill_in "firstname", :with => 'invalid'
	fill_in "lastname", :with => 'name'
end

When /^I enter only a firstname$/ do
	fill_in "firstname", :with => another_user_hash[:firstname]
end

When /^I select Promote$/ do
	choose "todo_promote"
end

When /^I select Demote$/ do
	choose "todo_demote"
end

When /^I press the Save button$/ do
	click_link_or_button "Save"
end

When /^I click on Manage Users$/ do
	click_link_or_button "Manage Users"
end

When /^I enter an email adress of an unblocked user$/ do
	@user_mail = "unblocked@example.com"
	create_confirmed_user({:email => @user_mail})
	fill_in "email", :with => @user_mail
end

When /^I enter an email adress of a blocked user$/ do
	@user_mail = "blocked@example.com"
	create_blocked_user({:email => @user_mail})
	fill_in "email", :with => @user_mail
end

When /^I enter an email adress of an administrator$/ do
	@user_mail = "admin@example.com"
	create_admin_user({:email => @user_mail})
	fill_in "email", :with => @user_mail
end

When /^I select Block$/ do
	choose "todo_block"
end

When /^I select Unblock$/ do
	choose "todo_unblock"
end

When /^I visit the Manage Users Page$/ do
	visit_manage_admin_page
end

Then /^I should be on the manage users page$/ do
	URI.parse(current_url).path.should == users_manage_path
end

Then /^the user should be blocked$/ do
	@user.blocked == true
end

Then /^the user should be unblocked$/ do
	@user.blocked == false
end

When /^I visit the new game page$/ do
	visit_game_creation_page
end