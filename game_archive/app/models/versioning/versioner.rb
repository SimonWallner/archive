require 'securerandom'

# this class brings all basic functionality for versioning an active record model
class Versioner

  # returns a uuid as string
  def next_version_id
    SecureRandom.uuid.to_s
  end

  # returns all current versions of of the provided active record model class
  def all_current_versions
    current_versions_from_collection model_class.order('version_id ASC, version_number DESC')
  end

  def current_versions_from_collection(collection)
    if collection == nil
      return
    end
    last_version_id = -1
    ret = Array.new
    collection.each do |v|
      if last_version_id == -1 || last_version_id != v.version_id
        last_version_id = v.version_id
        ret.push v
      end
    end
    ret
  end

  # returns the most current version of this object
  def current_version(obj)
    if obj == nil
      return
    end
    max_ver = nil
    # iterate through all games with certain object id, choose the version with the highest version id.
    model_class.find_all_by_version_id(obj.version_id).each do |v|
      if max_ver == nil || max_ver.version_number < v.version_number
        max_ver = v
      end
    end
    max_ver
  end

  # reverts to this version
  # for additional behaviour override revert_additional_behaviour
  def revert_to_this(obj)
    old_last = obj.current_version
    reverted = new_version old_last

    revert_additional_behaviour_before_save old_last, reverted

    reverted.save

    revert_additional_behaviour_after_save old_last, reverted

    reverted
  end

  # copies the current state and saves the new version
  # returns the new version
  def new_version(old)
    new = model_class.new
    new_version_additional_behaviour_before_save old, new
    new.save
    new_version_additional_behaviour_after_save old, new
    return new
  end

  def add_versioning_to_new_object(obj, current_user)
    # add version stuff
    obj.version_id = next_version_id
    obj.version_number = 1
    obj.version_author_id = current_user.id
    obj.version_updated_at = Time.now
  end

  protected
  # needs to be overridden in subclass
  # returns the active record model class object
  def model_class
    Versioner
  end

  # adds additional behaviour to the revert_to_this method before saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_before_save(old, new)
  end

  # adds additional behaviour to the revert_to_this method after saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_after_save(old, new)
  end

  # adds additional behaviour to the new_version method before saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, new)
  end

  # adds additional behaviour to the new_version method after saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_after_save(old, new)
  end

end