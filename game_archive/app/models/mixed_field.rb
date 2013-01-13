class MixedField < ActiveRecord::Base
  validates_presence_of :game_id, :mixed_field_type

  belongs_to :developer
  belongs_to :company
  belongs_to :mixed_field_type
  belongs_to :game
  belongs_to :series_game, :class_name => "Game", :foreign_key => :series_game_id

  attr_accessible :additional_info, :not_found

  # copies the fields without referenced fields
  def dup
    d = MixedField.new
    d.additional_info = self.additional_info
    d.not_found = self.not_found
    d.mixed_field_type_id = self.mixed_field_type_id
    d.series_game_id = self.series_game_id
    d.game_id = self.game_id
    d.developer_id = self.developer_id
    d.company_id = self.company_id
    return d
  end
end
