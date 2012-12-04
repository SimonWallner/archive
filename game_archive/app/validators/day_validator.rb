class DayValidator < ActiveModel::Validator
  def validate(record)
    day = record.day
    month = record.month
    if day == nil
      # no error as it can be nil
      return
    end
    if month == nil
      record.errors[:day] << "needs Month to be specified"
      return
    end
    if month == 2
      #february
      unless( (day > 0) && (day <= 28) )
        record.errors[:day] << "must be between 1 and 28"
      end
    elsif ([1,3,5,7,8,10,12] & [month]).empty?
      #30
      unless ( (day > 0) && (day <= 30) )
        record.errors[:day] << "must be between 1 and 30"
      end
    else
      #31
      unless ( (day > 0) && (day <= 31) )
        record.errors[:day] << "must be between 1 and 31"
      end
    end
  end
end