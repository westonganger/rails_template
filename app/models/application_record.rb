class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_validation :log_errors

  scope :alphanumeric_natural_sort, Proc.new{|*columns|
    relation = self
    columns.each do |c|
      relation = relation.order("(#{c} = '0') DESC, (#{c}+0 > 0) DESC, #{c}+0 ASC, #{c} ASC")
    end
    relation
  }

  ### Check validations for only specific attribute(s)
  def attribute_valid?(*attributes)
    valid = true

    attributes.each do |attr|
      self.class.validators_on(attr).each do |validator|
        validator.send(:validate_each, self, attr, send(attr))
      end

      if errors[attr].present?
        valid = false
      end
    end

    return valid
  end

  private
  
  ### Output all validation in dev/test for easier debugging
  def log_errors
    if !Rails.env.production? && self.errors.any?
      str = "Errors for #{self.class.name}"
      if id
        str += " (ID: #{self.id})"
      end
      str += "  -  #{self.errors.full_messages.join(', ')}"

      str = "\n#{str}\n"

      if Rails.env.test?
        puts str
      else
        Rails.logger.debug(str)
      end
    end
  end

end
