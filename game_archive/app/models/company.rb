class Company < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :name, :image

  has_many :locations, :inverse_of => :company
  has_many :mixed_fields
  has_many :fields, :inverse_of => :company
  accepts_nested_attributes_for :fields, :locations

  validates :name, :presence => true

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
