class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  has_and_belongs_to_many :games
  
    def Tag.create_from_string(tags_string)
      
                        if tags_string == nil  
      logger.debug "no tag to create"
      return
    end
    
    
    tags_string.strip!
    tags = tags_string.split ','
    tags_to_return = Array.new

    tags.each do |g|
      g.strip!
      if g.length > 0 && (not Tag.exists?(:name => g))
        logger.debug "new tag: " + g
        new_tag = Tag.new :name => g
        new_tag.save
        tags_to_return << new_tag
      else
        logger.debug "tag already created: " + g
      end
    end

    logger.debug "saved tags: " + tags_to_return.size.to_s
    return tags_to_return
  end
  
end
