class Mode < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  has_and_belongs_to_many :games
  
    def Mode.create_from_string(modes_string)
             if modes_string == nil  
      logger.debug "no mode to create"
      return
    end
    
    modes_string.strip!
    modes = modes_string.split ','
    modes_to_return = Array.new

    modes.each do |g|
      g.strip!
      if g.length > 0 && (not Mode.exists?(:name => g))
        logger.debug "new mode: " + g
        new_mode = Mode.new :name => g
        new_mode.save
        modes_to_return << new_mode
      else
        logger.debug "mode already created: " + g
      end
    end

    logger.debug "saved modes: " + modes_to_return.size.to_s
    return modes_to_return
  end
end
