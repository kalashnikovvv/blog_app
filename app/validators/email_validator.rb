class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEXP = /\A([-a-z0-9+._]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || :invalid_email) if value !~ EMAIL_REGEXP
  end
end
