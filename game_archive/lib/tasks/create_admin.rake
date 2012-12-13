namespace :db do
  desc "Create default admin account"
  task create_default_admin: :environment do
    admin = User.new(email: "admin@admin.com",
                         password: "aA1aaaa",
                         password_confirmation: "aA1aaaa",
                         firstname: "admin",
                         lastname: "admin")
    admin.skip_confirmation!
    admin.save
    admin.toggle!(:admin)
  end

  desc "drop default admin account"
  task drop_default_admin: :environment do
    admin = User.find_by_email "admin@admin.com"
    admin.delete
  end
end