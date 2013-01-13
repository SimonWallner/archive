namespace :db do
  desc "add versioning"
  task add_versioning: :environment do
    games = Game.all
    time = Time.now
    versioner = Versioner.new
    users = User.all
    if users != nil && ( not users.empty? )
      u = users.first.id
    else
      u = 1
    end

    games.each do |g|
      if g.version_id == nil
        puts "add versioning to game #{g.id}"
        g.version_id = versioner.next_version_id
        g.version_number = 1
        g.version_updated_at = time
        g.version_author_id = u
        g.save!
      else
        puts "no versioning added for game #{g.id}"
      end
    end
  end
end