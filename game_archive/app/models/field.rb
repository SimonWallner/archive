require "json"

class Field < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :game, :inverse_of => :fields
  belongs_to :company, :inverse_of => :fields
  belongs_to :developer, :inverse_of => :fields

  attr_accessible :content, :name

  # create new user defined field
  # content will be parsed as markdown with just links
  def Field.create_add_new_fields(object, field_string)
    if object == nil || object.fields == nil
      logger.debug "no object passed where fields can be attached to"
      return
    end
    object.fields.clear
    if field_string == nil || field_string.length < 2
      logger.debug "field_string not provided or to short"
      return
    end

    logger.debug field_string
    json_object = JSON.parse field_string
    logger.debug json_object

    if ( not json_object.is_a?( Array ) )
      logger.debug "json object is no Array"
      return
    end

    json_object.each do |field|
      if field["name"] == nil || field["content"] == nil
        #invalid field
        logger.debug "invalid field"
        logger.debug field
        next
      end

      f = Field.new :name => field["name"], :content => field["content"]
      logger.debug f
      object.fields.push f
    end
  end

  def as_json(options={})
    { :type => { :MixedFieldType => :name } }
  end

end
