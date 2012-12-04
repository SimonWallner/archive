class MonthValidator < ActiveModel::Validator
  def validate(record)
    month = record.month
    if month == nil
      return
    end
    unless month > 0 && month <= 12
      record.errors[:month] << "must be between 1 and 12"
    end
  end
end