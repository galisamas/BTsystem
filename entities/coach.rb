require './entities/person.rb'

# This is Coach class
class Coach < Person
  def initialize(name, last_name, gender, level = 'assistant')
    super(name, last_name, gender)
    @level = level
  end
  attr_reader :level
end
