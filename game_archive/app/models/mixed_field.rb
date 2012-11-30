class MixedField < ActiveRecord::Base

  belongs_to :developer
  belongs_to :company
  belongs_to :type
  belongs_to :game

  attr_accessible :additionalInfo, :notFound, :developer, :company, :type, :game, :game_id, :developer_id, :company_id, :type_id
end
