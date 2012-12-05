class Game < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :title, :image, :release_dates
  #see if this is needed  :genres, :genre_ids ,

  validates :title, :presence => true

  has_many :mixed_fields
  has_many :release_dates, :inverse_of => :game
  has_many :fields, :inverse_of => :game
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :media
  has_and_belongs_to_many :modes
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :genres, :release_dates, :platforms, :media, :modes, :tags, :fields

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
