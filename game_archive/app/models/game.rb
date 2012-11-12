class Game < ActiveRecord::Base
  attr_accessible :description, :title, :genres, :genre_ids

  validates :title, :presence => true

  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :genres
end
