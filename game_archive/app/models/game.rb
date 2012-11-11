class Game < ActiveRecord::Base
  attr_accessible :description, :title
  validates :title, :presence => true

  has_and_belongs_to_many :genres
end
