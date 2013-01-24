require 'securerandom'

# this class brings all basic functionality for versioning an active record model
class Versioner

  # returns a uuid as string
  def next_version_id
    SecureRandom.uuid.to_s
  end

  # returns all current versions of of the provided active record model class
  def all_current_versions
    collection = model_class.order('version_id ASC, version_number DESC')
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

  def current_versions_from_collection(collection)
    return if collection == nil

    hash = Hash.new
    ret = Array.new
    pos = 0
    collection.each do |v|
      v_id = v.version_id
      hash_elem = hash[v_id]
      if hash_elem == nil
        # element is not in return yet
        col_el = CollectionElement.new
        col_el.setElement = v
        col_el.setPosition = pos
        hash[v_id] = col_el
        ret.push v
        pos += 1
      elsif hash_elem.getElement.version_number < v.version_number
        ret[hash_elem.getPosition.to_i] = v
        hash_elem.setElement = v
      end
    end
    ret
  end

  # returns the mixed fields with the current version
  # should be overridden in subclass in order to define which field should be just in the newest version
  def current_version_mixed_fields(mfs)
    mfs
  end

  # returns the most current version of this object
  def current_version(obj)
    return if obj == nil
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
    old_last = current_version obj
    reverted = new_version obj, nil

    revert_additional_behaviour_before_save obj, old_last, reverted

    reverted.save

    revert_additional_behaviour_after_save obj, old_last, reverted

    reverted
  end

  # copies the current state and saves the new version
  # returns the new version
  def new_version(old, params)
    new = model_class.new
    new.version_id = old.version_id
    new.version_author_id = old.version_author_id
    # version number
    new.version_number = ( current_version(old).version_number + 1 )

    new_version_additional_behaviour_before_save old, new, params
    new.version_updated_at = Time.now
    new.save
    new_version_additional_behaviour_after_save old, new, params
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
  def revert_additional_behaviour_before_save(revert_to, current_newest, new)
  end

  # adds additional behaviour to the revert_to_this method after saving the record
  # override in subclass if wanted
  def revert_additional_behaviour_after_save(revert_to, current_newest, new)
  end

  # adds additional behaviour to the new_version method before saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, new, params)
  end

  # adds additional behaviour to the new_version method after saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_after_save(old, new, params)
  end

  def change_rbc(old, new, content_type)
    # report block content
    rbc = Reportblockcontent.find_all_by_content_type_and_content_id(content_type, old.id)
    return if rbc == nil
    rbc.each do |rbc|
      cp = rbc.copy_without_references
      cp.content_id = new.id
      new.reportblockcontent.push cp
      rbc.destroy
    end
  end

  private
  class CollectionElement

    def setElement=(element)
      @element = element
    end

    def getElement
      @element
    end

    def setPosition=(pos)
      @pos = pos
    end

    def getPosition
      @pos
    end
  end

end