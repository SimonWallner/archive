class Genre < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true
  has_and_belongs_to_many :games
end
