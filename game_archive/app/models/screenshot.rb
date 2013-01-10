class Screenshot < ActiveRecord::Base

  require 'file_size_validator'

  belongs_to :game
  attr_accessible :image

  mount_uploader :image , ScreenshotUploader

  validates :image,
            :file_size => {
                :maximum => 1.megabytes.to_i
            }

  def copy_without_references
    clone = Screenshot.new
    clone.image = self.image
    return clone
  end
end
