class Game < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :title, :genres, :genre_ids , :image

  validates :title, :presence => true

  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres

  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
