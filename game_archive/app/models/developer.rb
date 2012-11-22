class Developer < ActiveRecord::Base
  attr_accessible :description, :name , :image

  validates :name, :presence => true

  mount_uploader :image , ImageUploader

  def to_json
    ActiveSupport::JSON.encode({
    :value => id ,
    :label => name
    })
  end
end
