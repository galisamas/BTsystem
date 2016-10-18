# This is Contact class
class Contact
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  VALID_PHONE_REGEX = /\A(\+\d{1,3}\s)?\(?\d{3}\)?[\s-]?\d{3,5}\z/
  def initialize
    @phone = ''
    @email = ''
  end

  def email=(new_email)
    @email = new_email if new_email =~ VALID_EMAIL_REGEX
  end

  def phone=(new_phone)
    @phone = new_phone if new_phone =~ VALID_PHONE_REGEX
  end

  attr_reader :email, :phone
end