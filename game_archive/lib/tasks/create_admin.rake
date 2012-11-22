namespace :db do
  desc "Create default admin account"
  task create_default_admin: :environment do
    admin = User.create!(email: "admin@admin.com",
                         password: "123456",
                         password_confirmation: "123456",
                         firstname: "admin",
                         lastname: "admin")
    admin.toggle!(:admin)
  end
end