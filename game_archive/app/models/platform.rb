class Platform < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_and_belongs_to_many :games
  
    def Platform.create_from_string(platforms_string)
    platforms_string.strip!
    platforms = platforms_string.split ','
    platforms_to_return = Array.new

    platforms.each do |g|
      g.strip!
      if g.length > 0 && (not Platform.exists?(:name => g))
        logger.debug "new platforms: " + g
        new_platform = Platform.new :name => g
        new_platform.save
        platforms_to_return << new_platform
      else
        logger.debug "platform already created: " + g
      end
    end

    logger.debug "saved platforms: " + platforms_to_return.size.to_s
    return platforms_to_return
  end
  
end
