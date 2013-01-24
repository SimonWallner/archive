class GameVersioner < Versioner

  @@instance = GameVersioner.new

  def self.instance
    @@instance
  end

  def new_video_hash(old)
    newest = current_version old
    hash = Hash.new
    ovs = Array.new(old.videos)
    nvs = Array.new(newest.videos)
    ovs.each do |ov|
      nvs.each do |nv|
        if nv.embedcode == ov.embedcode
          hash[ov.id] = nv.id
          nvs.delete nv
          break
        end
      end
    end
    return hash
  end

  # returns the mixed fields with the current version
  def current_version_mixed_fields(mfs)
    return if mfs == nil
    g_hash = Hash.new
    ret_array = Array.new
    mfs.each do |mf|
      g = g_hash[mf.game.version_id]
      if g == nil
        g = current_version mf.game
        g_hash[mf.game.version_id] = g
      end
      if mf.game_id == g.id
        ret_array.push mf
      end
    end
    ret_array
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
  def new_version_additional_behaviour_before_save(old, new, params)
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

    screenshot_versioning old, new, params

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
  def new_version_additional_behaviour_after_save(old, new, params)
    # change report/block/delete
    change_rbc old, new, 0
    copy_mixed_fields old, new
    mixed_fields_update_series_references old, new
  end

  def copy_mixed_fields(old, new)
    # mixed fields
    old.mixed_fields.each do |mf|
      nmf = mf.dup
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

  private
  def screenshot_versioning(old, new, params)
    # screenshots
    puts 'version screenshots'
    if params != nil
      sp = params[:game][:screenshots_attributes]
      new_sp = HashWithIndifferentAccess.new
      puts sp
      if sp != nil
        count = 0
        sp.each do |k, v|
          id = v[:id]
          image = v[:image]
          des = v[:_destroy]
          if des != "false"
            puts "screenshot #{k} with id #{id} deleted"
            next
          elsif image == ""
            # old image
            puts "screenshot #{k} with id #{id} is old -> copy to new version"
            old_ss = Screenshot.find(id.to_i)
            new.screenshots.push old_ss.copy_without_references unless old_ss == nil
          else
            # new screenshot -> leave in params
            puts "screenshot #{k} with id #{id} is new -> leave in params on position #{count}"
            new_sp[count.to_s] = sp[k]
            count += 1
          end
        end
        params[:game][:screenshots_attributes] = new_sp
      end
      puts sp
      puts 'version screenshots end'
    else
      # params nil -> just copy old screenshots
      old.screenshots.each do |os|
        new.screenshots.push os.copy_without_references
      end
    end
  end
end