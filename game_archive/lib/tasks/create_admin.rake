namespace :db do
  desc "Create default admin account (admin@example.com:aA1aaaa)."
  task create_default_admin: :environment do
    puts 'email: admin@example.com; pwd: aA1aaaa'
    admin = User.new(email: "admin@example.com",
                         password: "aA1aaaa",
                         password_confirmation: "aA1aaaa",
                         firstname: "admin",
                         lastname: "admin")
    admin.skip_confirmation!
    admin.save
    admin.toggle!(:admin)
	  admin.blocked = false
  end

  desc "drop default admin account (admin@example.com)."
  task drop_default_admin: :environment do
    admin = User.find_by_email "admin@example.com"
    admin.delete
  end
end