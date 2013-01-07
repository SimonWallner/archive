class Location < ActiveRecord::Base
  validates_presence_of :name, :company

  belongs_to :company, :inverse_of => :locations
  attr_accessible :additional_info, :name

  # create new user defined location
  # location string must be a json array containing location objects
  # location object: { "name":"Wien", "additional_info":"HQ" }
  # whereas the field name is mandatory and the field additional_info is optional
  def Location.create_add_new_locations(object, location_string)
    if object == nil || object.fields == nil
      logger.debug "no object passed where locations can be attached to"
      return
    end
    object.locations.clear
    if location_string == nil || location_string.length < 2
      logger.debug "location_string not provided or to short"
      return
    end

    logger.debug location_string
    json_object = JSON.parse location_string
    logger.debug json_object

    if ( not json_object.is_a?( Array ) )
      logger.debug "json object is no Array"
      return
    end

    json_object.each do |location|
      if location["name"] == nil
        #invalid location
        logger.debug "invalid location"
        logger.debug location
        next
      end

      f = Location.new :name => location["name"], :additional_info => location["additional_info"]
      logger.debug f
      object.locations.push f
    end
  end
end
