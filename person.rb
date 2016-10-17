# This is Person class
class Person
  def initialize(name, last_name, gender)
    @name = name
    @last_name = last_name
    @gender = gender
  end
  attr_reader :name, :last_name, :gender
end
