require './entities/coach.rb'

# This is Team class
class Team
  def initialize(name, owner)
    @name = name
    @owner = owner
    @establishment = Date.today
    @coaches = []
  end

  def name=(new_name)
    @name = new_name unless new_name.empty?
  end
  attr_reader :name, :coaches, :owner, :establishment

  def add_coach(coach)
    @coaches << coach
  end

  def coach_count
    @coaches.length
  end
end
