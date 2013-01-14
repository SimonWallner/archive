module MyActiveRecordExtensions
  extend ActiveSupport::Concern

  def add_errors(from)
    return if from == nil
    from.each do |key, value|
      self.errors[key].push value
    end
  end
end

# include the extension
ActiveRecord::Base.send(:include, MyActiveRecordExtensions)