class Game < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :title, :image, :release_dates
  #see if this is needed  :genres, :genre_ids ,

  validates :title, :presence => true

  has_many :mixed_fields
  has_many :release_dates
  has_and_belongs_to_many :genres
  #has_many :mixed_fields, :foreign_key => :series_game_id
  accepts_nested_attributes_for :genres, :release_dates

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
