class Game < ActiveRecord::Base

  acts_as_indexed :fields => [:description, :title]
  require 'file_size_validator'

  attr_accessible :description, :title, :genres, :genre_ids , :image, :videos_attributes, :popularity, :screenshots_attributes , :remove_image, :release_dates

  validates :title, :presence => true

  has_many :mixed_fields
  has_many :release_dates, :inverse_of => :game
  has_many :fields, :inverse_of => :game
  has_many :reportblockcontent
  
  has_many :videos, :dependent => :destroy
  accepts_nested_attributes_for :videos, :reject_if => lambda { |a| a[:embedcode].blank? }, :allow_destroy => true

  has_many :screenshots, :dependent => :destroy
  accepts_nested_attributes_for :screenshots, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true

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

  def as_json(options = {})
    super(:include => [{:mixed_fields => {:include => :mixed_field_type}}, :release_dates, :fields, :genres, :platforms, :media, :modes, :tags ])
  end
end
