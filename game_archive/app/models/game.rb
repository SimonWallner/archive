class Game < ActiveRecord::Base
  require 'file_size_validator'

  attr_accessible :description, :title, :genres, :genre_ids , :image, :videos_attributes, :popularity, :screenshots_attributes , :remove_image

  validates :title, :presence => true

  has_many :reportblockcontent
  
  has_many :videos, :dependent => :destroy
  accepts_nested_attributes_for :videos, :reject_if => lambda { |a| a[:embedcode].blank? }, :allow_destroy => true

  has_many :screenshots, :dependent => :destroy
  accepts_nested_attributes_for :screenshots, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true

  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres


  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }

end
