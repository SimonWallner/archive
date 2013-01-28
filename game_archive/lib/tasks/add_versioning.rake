namespace :db do
  desc "add versioning"
  task add_versioning: :environment do
    time = Time.now
    versioner = Versioner.new
    users = User.all
    if users != nil && ( not users.empty? )
      u = users.first.id
    else
      u = 1
    end

    add_version = lambda {
      |obj, type|
      obj.each do |o|
        if o.version_id == nil
          puts "add versioning to #{type} #{o.id}"
          o.version_id = versioner.next_version_id
          o.version_number = 1
          o.version_updated_at = time
          o.version_author_id = u
          o.save!
        else
          puts "no versioning added for #{type} #{o.id}"
        end
      end
    }

    add_version.call Game.all, "game"
    add_version.call Developer.all, "developer"
    add_version.call Company.all, "company"
  end
end