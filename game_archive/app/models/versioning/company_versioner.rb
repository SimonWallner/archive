class CompanyVersioner < Versioner

  @@instance = CompanyVersioner.new

  def self.instance
    @@instance
  end

  protected
  # needs to be overridden in subclass
  # returns the active record model class object
  def model_class
    Company
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
    change_rbc current_newest, new, 2
    mixed_fields_reference_update revert_to, new
  end

  #adds additional behaviour to the new_version method
  # override in sublass if wanted
  def new_version_additional_behaviour_before_save(old, new)
    new.name = old.name
    new.description = old.description
    new.official_name = old.official_name
    new.created_at = old.created_at
    new.image = old.image
    new.popularity = old.popularity

    # fields
    old.fields.each do |f|
      new.fields.push f.copy_without_references
    end

    old.locations.each do |l|
      nl = l.dup
      nl.company_id = nil
      new.locations.push nl
    end

    cd = old.defunct
    cf = old.founded
    new.build_defunct :year => cd.year, :month => cd.month, :day => cd.day, :additional_info => cd.additional_info unless cd == nil
    new.build_founded :year => cf.year, :month => cf.month, :day => cf.day unless cf == nil

    new.updated_at = Time.now
  end

  # adds additional behaviour to the new_version method after saving the record
  # override in sublass if wanted
  def new_version_additional_behaviour_after_save(old, new)
    # change report/block/delete
    change_rbc old, new, 2
    mixed_fields_reference_update old, new
  end

  def mixed_fields_reference_update(old, new)
    # mixed fields
    old.mixed_fields.each do |mf|
      nmf.company_id = new.id
      nmf.save
    end
  end
end