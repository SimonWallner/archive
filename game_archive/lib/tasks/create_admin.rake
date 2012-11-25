namespace :db do
  desc "Create default admin account"
  task create_default_admin: :environment do
    invitation_token = "abcd123"
    admin = User.create!(email: "admin@test.com",
                         password: "aA1aaaa",
                         password_confirmation: "aA1aaaa",
                         firstname: "admin",
                         lastname: "admin",
						 invitation_token: invitation_token )
    admin.toggle!(:admin)
    User.accept_invitation!(:invitation_token => invitation_token,
                          :password => "aA1aaaa")
  end

  desc "drop default admin account"
  task drop_default_admin: :environment do
    admin = User.find_by_email "admin@test.com"
    admin.delete
  end
end