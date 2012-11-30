class Video < ActiveRecord::Base
  belongs_to :game
  attr_accessible :embedcode
end
