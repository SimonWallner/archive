class Medium < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_and_belongs_to_many :games
  
    def Medium.create_from_string(media_string)
    media_string.strip!
    media = media_string.split ','
    media_to_return = Array.new

    media.each do |g|
      g.strip!
      if g.length > 0 && (not Medium.exists?(:name => g))
        logger.debug "new medium: " + g
        new_medium = Medium.new :name => g
        new_medium.save
        media_to_return << new_medium
      else
        logger.debug "medium already created: " + g
      end
    end

    logger.debug "saved media: " + media_to_return.size.to_s
    return media_to_return
  end
end
