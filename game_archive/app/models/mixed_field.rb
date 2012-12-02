class MixedField < ActiveRecord::Base

  belongs_to :developer
  belongs_to :company
  belongs_to :mixed_field_type
  belongs_to :game

  attr_accessible :additional_info, :not_found
end
