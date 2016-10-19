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
    @coaches << coach if original(@coaches, coach.name)
  end

  def delete_at(index)
    @coaches.delete_at(index)
  end

  def coach_count
    @coaches.length
  end

  private

  def original(coaches, name)
    coaches.each do |coach|
      if coach.name == name
        return false
      end
    end
    true
  end
end
