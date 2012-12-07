class Company < ActiveRecord::Base
  require 'file_size_validator'
  attr_accessible :description, :name  , :image, :popularity
  validates :name, :presence => true


  mount_uploader :image , ImageUploader

  validates :image,
            :file_size => {
                :maximum => 0.4.megabytes.to_i
            }
end
