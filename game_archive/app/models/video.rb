class Video < ActiveRecord::Base
  belongs_to :game
  attr_accessible :embedcode

  def copy_without_references
    clone = Video.new
    clone.embedcode = self.embedcode
    return clone
  end
end
