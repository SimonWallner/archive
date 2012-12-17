# creation helpers and steps

def create_confirmed_user
  @user = FactoryGirl.create :confirmed_user
end

def create_unconfirmed_user
  @user = FactoryGirl.create :user
end

Given /^I have a user$/ do
  create_confirmed_user
end

Given /^I have an unconfirmed user$/ do
  create_unconfirmed_user
end

# confirmation helpers and steps

def confirm_user
  @user.reload
  @user.confirm!
  @email_confirmed = true
end

When /^I confirm my email$/ do
  confirm_user
end

When /^I don't confirm my email$/ do
  # do nothing
  @email_confirmed = false
end
