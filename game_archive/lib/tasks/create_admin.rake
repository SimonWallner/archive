namespace :db do
  desc "Create default admin account"
  task create_default_admin: :environment do
    admin = User.create!(email: "admin@test.com",
                         password: "123456",
                         password_confirmation: "123456",
                         firstname: "admin",
                         lastname: "admin",
						 invitation_token: "abcd123")
    admin.toggle!(:admin)
  end
end