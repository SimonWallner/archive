require "json"

class CompanyDefunct < ActiveRecord::Base
  validates_presence_of :company, :year
  validates :year, :numericality => { :greater_than_or_equal_to => 1900 }
  validates_with MonthValidator
  validates_with DayValidator

  belongs_to :company, :inverse_of => :defunct
  attr_accessible :additional_info, :day, :month, :year
end
