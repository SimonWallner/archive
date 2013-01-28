class ReleaseDate < ActiveRecord::Base
  validates_presence_of :game, :year
  validates :year, :numericality => { :greater_than_or_equal_to => 1900 }
  validates_with MonthValidator
  validates_with DayValidator

  belongs_to :game, :inverse_of => :release_dates
  attr_accessible :additional_info, :day, :month, :year

  # string form:
  # [rd] == dd:mm:yyyy:additional_info
  # dd, mm, additional_info is optional, BUT the colons need to be present
  # if dd or mm is not needed, put -1 in place
  # a comma seperates release dates from each other
  # [rd],[rd],[rd]
  # returns an array with the release dates
  def ReleaseDate.create_from_string(rd_string)
    rd_string.strip!
    rds = rd_string.split(',')
    rdArray = Array.new

    rds.each do |rd|
      logger.debug "parse rd: " + rd
      next if rd == nil
      rd.strip!
      rdParts = rd.split ':'
      logger.debug "parts: " + rdParts.size.to_s
      next if rdParts == nil || rdParts.size < 3
      logger.debug "splitted rd, create object"
      year = rdParts[2].strip.to_i
      month = rdParts[1].strip.to_i
      day = rdParts[0].strip.to_i
      if rdParts.size == 4
        additional_info = rdParts[3].strip
      end
      date = ReleaseDate.new :year => year, :month => ( month < 0 ? nil : month ), :day => ( day < 0 ? nil : day ), :additional_info => additional_info
      logger.debug "date is ready"
      rdArray.push date
    end

    return rdArray
  end
  
  
 
    
    def ReleaseDate.check_from_string(rd_string)
    rds = Array.new
    rd_string.strip!
    rds = rd_string.split(':') 
    rds.each do |rd| 
    if rd == "nil"
      return nil 
    else
      rd.strip!   
      year = rds[2].strip.to_i
      month = rds[1].strip.to_i
      day = rds[0].strip.to_i
      if rds.size == 4
        additional_info = rds[3].strip
      end
  end 
    end
return 1

    end

  def copy_without_references
    clone = ReleaseDate.new
    clone.year = self.year
    clone.month = self.month
    clone.day = self.day
    clone.additional_info = self.additional_info
    return clone
  end
end
