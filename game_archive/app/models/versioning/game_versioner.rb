class GameVersioner < Versioner

  @@instance = GameVersioner.new

  def self.instance
    @@instance
  end

  protected
  # needs to be overridden in subclass
  # returns the active record model class object
  def model_class
    Game
  end

  # adds additional behaviour to the revert_to_this method
  # override in subclass if wanted
  def revert_additional_behaviour_before_save(old, new)
    # change attributes from most recent version
    new.popularity = old.popularity
  end

  # adds additional behaviour to the revert_to_this method after saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_after_save(old, new)
    # change report/block/delete
    change_rbc old, new
  end

  #adds additional behaviour to the new_version method
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, new)
    new.title = old.title
    new.description = old.description
    new.created_at = old.created_at
    new.updated_at = old.updated_at
    new.image = old.image
    new.popularity = old.popularity
    new.version_id = old.version_id
    new.version_updated_at = old.version_updated_at
    new.version_author_id = old.version_author_id

    # version number
    new.version_number = ( current_version(old).version_number + 1 )

    # fields
    old.fields.each do |f|
      new.fields.push f.copy_without_references
    end

    # release dates
    old.release_dates.each do |rd|
      new.release_dates.push rd.copy_without_references
    end

    # videos
    old.videos.each do |v|
      new.videos.push v.copy_without_references
    end

    # screenshots
    old.screenshots.each do |ss|
      new.screenshots.push ss.copy_without_references
    end

    # genres
    old.genres.each do |g|
      new.genres.push g
    end

    # platforms
    old.platforms.each do |p|
      new.platforms.push p
    end

    # media
    old.media.each do |m|
      new.media.push m
    end

    # modes
    old.modes.each do |m|
      new.modes.push m
    end

    # tags
    old.tags.each do |t|
      new.tags.push t
    end

  end

  # adds additional behaviour to the new_version method after saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_after_save(old, new)
    # change report/block/delete
    change_rbc old, new
  end

  def change_rbc(old, new)
    # report block content
    rbc = Reportblockcontent.find_by_content_type_and_content_id(0, old.id)
    if rbc == nil
      return
    end
    rbc.each do |rbc|
      cp = rbc.copy_without_references
      cp.content_id = new.id
      new.reportblockcontent.push cp
      rbc.destroy
    end
  end

end