Given /^I am not signed in$/ do
  visit('/users/sign_out')
end

Given /^I am signed in as (.+)$/ do |role|

  email = 'user@user.com'
  password = 'password'
  @user = User.new(:email => email, :password => password, :password_confirmation => password)
  @user.save!

  if role == 'Admin'
    @user.toggle :admin
  end

  visit '/users/sign_in'
  fill_in 'user_email', :with => email
  fill_in 'user_password', :with => password
  click_link_or_button 'Sign in'
end