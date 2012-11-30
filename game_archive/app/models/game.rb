class Game < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :title, :image
  #see if this is needed  :genres, :genre_ids ,

  validates :title, :presence => true

  has_many :mixed_fields
  accepts_nested_attributes_for :mixed_fields

  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
