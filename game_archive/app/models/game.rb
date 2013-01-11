require 'securerandom'

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

  # returns a uuid as string
  def Game.next_object_id
    SecureRandom.uuid.to_s
  end

  # returns all current versions of all games
  def Game.all_current_versions
    Game.current_versions_from_collection Game.order('object_id ASC, version_number DESC')
  end

  def Game.current_versions_from_collection(collection)
    last_obj_id = -1
    ret = Array.new
    collection.each do |g|
      if last_obj_id == -1 || last_obj_id != g.object_id
        last_obj_id = g.object_id
        ret.push g
      end
    end
    ret
  end

  def as_json(options = {})
    super(:include => [{:mixed_fields => {:include => :mixed_field_type}}, :release_dates, :fields, :genres, :platforms, :media, :modes, :tags ])
  end

  # returns the most current version of this object
  def current_version
    max_ver = nil
    # iterate through all games with certain object id, choose the version with the highest version id.
    Game.find_all_by_object_id(self.object_id).each do |game|
      if max_ver == nil || max_ver.version_number < game.version_number
        max_ver = game
      end
    end
    max_ver
  end

  # reverts to this version
  def revert_to_this
    new_version
  end

  # copies the current state and saves the new version
  # returns the new version
  def new_version
    clone = Game.new
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
    clone.version_number = ( current_version.version_number + 1 )

    # fields
    self.fields.each do |f|
      clone.fields.push f.copy_without_references
    end

    # release dates
    self.release_dates.each do |rd|
      clone.release_dates.push rd.copy_without_references
    end

    # videos
    self.videos.each do |v|
      clone.videos.push v.copy_without_references
    end

    # screenshots
    self.screenshots.each do |ss|
      clone.screenshots.push ss.copy_without_references
    end

    # genres
    self.genres.each do |g|
      clone.genres.push g
    end

    # platforms
    self.platforms.each do |p|
      clone.platforms.push p
    end

    # media
    self.media.each do |m|
      clone.media.push m
    end

    # modes
    self.modes.each do |m|
      clone.modes.push m
    end

    # tags
    self.tags.each do |t|
      clone.tags.push t
    end

    clone.save
    logger.debug "clone saved with id: #{clone.id}"
    return clone
  end

  def change_rbc(old)
    # report block content
    rbc = Reportblockcontent.find_by_content_type_and_content_id(0, old.id)
    if rbc == nil
      return
    end
    rbc.each do |rbc|
      cp = rbc.copy_without_references
      cp.content_id = self.id
      self.reportblockcontent.push cp
    end
  end
end
