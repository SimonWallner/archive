class Genre < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  has_and_belongs_to_many :games

  # creates genres from a string
  # the string can contain multiple genres, all comma seperated
  # if genre has not already been created a new genre with the given name is created
  # otherwise if genre with the name has already been created, nothing is done
  def Genre.create_from_string(genres_string)
    
 if genres_string == nil  
      logger.debug "no genres to create"
      return
    end
    
    genres_string.strip!
    genres = genres_string.split ','
    genres_to_return = Array.new

    genres.each do |g|
      g.strip!
      if g.length > 0 && (not Genre.exists?(:name => g))
        logger.debug "new genre: " + g
        new_genre = Genre.new :name => g
        new_genre.save
        genres_to_return << new_genre
      else
        logger.debug "genre already created: " + g
      end
    end

    logger.debug "saved genres: " + genres_to_return.size.to_s
    return genres_to_return
  end
end
