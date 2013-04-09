#######################################
#
# creation helpers and steps
#
#######################################

private
def create_user(type, user_hash)
	if type == nil
		return
	end
	if @pwd == nil
		@pwd = "aA1aaaa"
		user_hash['password'] = @pwd
	end
	@blocked = user_hash['blocked']
	if @blocked == nil
		user_hash['blocked'] = false
		@blocked = false
	end

	case type
		when :unconfirmed
			@user = FactoryGirl.create :user, user_hash
		when :admin
			@user = FactoryGirl.create :admin_user, user_hash
	when :blocked
		@user = FactoryGirl.create :confirmed_user, user_hash
		@user.blocked = true
		@user.note = "blocked"
		@user.save
		else
			@user = FactoryGirl.create :confirmed_user, user_hash
	end

	@email = @user.email
	@firstname = @user.firstname
	@lastname = @user.lastname

	@user
end

public
def create_confirmed_user(user_hash)
	create_user :confirmed, user_hash
end

def create_unconfirmed_user(user_hash)
	create_user :unconfirmed, user_hash
end

def create_admin_user(user_hash)
	create_user :admin, user_hash
end

def create_blocked_user(user_hash)
	create_user :blocked, user_hash
end

def another_user_hash
	return {
			:firstname => "Another",
			:lastname => "Name",
			:email => "another@example.com"
	}
end

# creation steps

Given /^I have a user$/ do
	create_confirmed_user({})
end

Given /^I have an unconfirmed user$/ do
	create_unconfirmed_user({})
end

Given /^I have another user who is admin$/ do
	another = FactoryGirl.create :admin_user, another_user_hash
	another.email.should == another_user_hash[:email]
end

Given /^I have another user who is not admin$/ do
	another = FactoryGirl.create :confirmed_user, another_user_hash
	another.email.should == another_user_hash[:email]
end

#######################################
#
# confirmation helpers and steps
#
#######################################

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

#######################################
#
# authentication
#
#######################################

Given /^I am not signed in$/ do
	visit('/users/sign_out')
end

Given /^I am signed in as (.+)$/ do |role|
	case role
		when 'Admin'
			create_admin_user({})
		when 'Blocked'
			create_blocked_user({})
		else
			create_confirmed_user({})
	end

	visit '/users/sign_in'
	fill_in 'user_email', :with => @email
	fill_in 'user_password', :with => @pwd
	click_link_or_button 'Sign in'
end
