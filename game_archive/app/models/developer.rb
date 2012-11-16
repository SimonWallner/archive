class Developer < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true

  def to_json
    ActiveSupport::JSON.encode({
    :value => id ,
    :label => name
    })
  end
end
