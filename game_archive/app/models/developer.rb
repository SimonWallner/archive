class Developer < ActiveRecord::Base
  require 'file_size_validator'

  attr_accessible :description, :name , :image, :popularity,:remove_image

  validates :name, :presence => true

  has_many :reportblockcontent
  has_many :mixed_fields
  has_many :fields, :inverse_of => :developer
  accepts_nested_attributes_for :fields

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }

  def as_json(options = {})
    super(:include => [{:mixed_fields => {:include => :mixed_field_type}}, :fields])
  end
end
