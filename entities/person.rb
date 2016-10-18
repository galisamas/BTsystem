require './entities/contact.rb'

# This is Person class
class Person
  def initialize(name, last_name, gender)
    @name = name
    @last_name = last_name
    @gender = gender
    @contact = Contact.new
  end
  attr_reader :name, :last_name, :gender, :contact

  def set_email(new_email)
    @contact.email = new_email
  end

  def set_phone(new_phone)
    @contact.phone = new_phone
  end
end
