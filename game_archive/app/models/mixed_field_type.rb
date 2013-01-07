class MixedFieldType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  attr_accessible :name

  has_many :mixed_fields
end
