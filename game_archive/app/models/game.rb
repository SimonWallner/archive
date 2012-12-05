class Game < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :title, :image, :release_dates, :genres, :genre_ids, :platforms, :platform_ids, :media, :medium_ids, :modes, :mode_ids , :tags, :tag_ids

  validates :title, :presence => true

  has_many :mixed_fields
  has_many :release_dates
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :media
  has_and_belongs_to_many :modes
  has_and_belongs_to_many :tags
  #has_many :mixed_fields, :foreign_key => :series_game_id
  accepts_nested_attributes_for :genres, :release_dates, :platforms, :media, :modes, :tags

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
