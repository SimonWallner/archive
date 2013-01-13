class DeveloperVersioner < Versioner
  @@instance = DeveloperVersioner.new

  def self.instance
    @@instance
  end

  protected
  # needs to be overridden in subclass
  # returns the active record model class object
  def model_class
    Developer
  end

  # adds additional behaviour to the revert_to_this method
  # override in subclass if wanted
  def revert_additional_behaviour_before_save(old, new)
  end

  # adds additional behaviour to the revert_to_this method after saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_after_save(old, new)
  end

  #adds additional behaviour to the new_version method
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, clone)
    clone.title = self.title
    clone.description = self.description
    clone.created_at = self.created_at
    clone.updated_at = self.updated_at
    clone.image = self.image
    clone.popularity = self.popularity
    clone.version_id = self.version_id
    clone.version_updated_at = self.version_updated_at
    clone.version_author_id = self.version_author_id

    # version number
    clone.version_number = ( current_version.version_number + 1 )

    # fields
    self.fields.each do |f|
      clone.fields.push f.copy_without_references
    end

    # release dates
    self.release_dates.each do |rd|
      clone.release_dates.push rd.copy_without_references
    end

    # videos
    self.videos.each do |v|
      clone.videos.push v.copy_without_references
    end

    # screenshots
    self.screenshots.each do |ss|
      clone.screenshots.push ss.copy_without_references
    end

    # genres
    self.genres.each do |g|
      clone.genres.push g
    end

    # platforms
    self.platforms.each do |p|
      clone.platforms.push p
    end

    # media
    self.media.each do |m|
      clone.media.push m
    end

    # modes
    self.modes.each do |m|
      clone.modes.push m
    end

    # tags
    self.tags.each do |t|
      clone.tags.push t
    end

  end

  # adds additional behaviour to the new_version method after saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_after_save(old, new)
  end
end