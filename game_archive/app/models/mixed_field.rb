class MixedField < ActiveRecord::Base
  validates_presence_of :game_id, :mixed_field_type

  belongs_to :developer
  belongs_to :company
  belongs_to :mixed_field_type
  belongs_to :game
  #belongs_to :game, :foreign_key => :series_game_id

  attr_accessible :additional_info, :not_found
end
