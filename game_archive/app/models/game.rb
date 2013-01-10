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

  def Game.next_object_id
    @@cur_obj_id = 0 if @@cur_obj_id == nil
    @@cur_obj_id += 1
  end

  # returns the most current version of this object
  def current_version

  end

  # reverts to this version
  def revert_to_this
    cur_ver = current_version

  end

  # copies the current state and saves the new version
  # returns the new version
  def new_version
    clone = Game.new
    clone.id = self.id
    clone.title = self.title
    clone.description = self.description
    clone.created_at = self.created_at
    clone.updated_at = self.updated_at
    clone.image = self.image
    clone.popularity = self.popularity
    clone.object_id = self.object_id
    clone.updated_ts = self.updated_ts
    clone.author_id = self.author_id

    # version number
    clone.version_number = ( self.current_version.version_number + 1 )
  end
end
