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

  # adds additional behaviour to the revert_to_this method before saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_before_save(revert_to, current_newest, new)
    # change attributes from most recent version
    new.popularity = current_newest.popularity
  end

  # adds additional behaviour to the revert_to_this method after saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_after_save(revert_to, current_newest, new)
    # change report/block/delete
    change_rbc current_newest, new, 0
    copy_mixed_fields revert_to, new
    mixed_fields_update_series_references revert_to, new
  end

  #adds additional behaviour to the new_version method
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, new)
    new.title = old.title
    new.description = old.description
    new.created_at = old.created_at
    new.updated_at = Time.now
    new.image = old.image
    new.popularity = old.popularity

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
    change_rbc old, new, 0
    copy_mixed_fields old, new
    mixed_fields_update_series_references old, new
  end

  def copy_mixed_fields(old, new)
    # mixed fields
    old.mixed_fields.each do |mf|
      nmf = mf.clone
      nmf.game_id = new.id
      nmf.save
    end
  end

  def mixed_fields_update_series_references(old, new)
    smf = MixedField.where(:series_game_id => old.id)
    if smf == nil
      return
    end

    smf.each do |smfe|
      smfe.series_game_id = new.id
      smfe.save
    end
  end

end