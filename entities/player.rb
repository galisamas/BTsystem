require './entities/person.rb'

# This is Player class
class Player < Person
  def initialize(name, last_name, gender, tshirt_n)
    super(name, last_name, gender)
    @tshirt_n = tshirt_n
  end
  attr_reader :tshirt_n
end
