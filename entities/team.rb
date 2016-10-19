require './entities/coach.rb'
require './entities/player.rb'

# This is Team class
class Team
  def initialize(name, owner)
    @name = name
    @owner = owner
    @establishment = Date.today
    @coaches = []
    @players = []
  end

  def name=(new_name)
    @name = new_name unless new_name.empty?
  end
  attr_reader :name, :coaches, :players, :owner, :establishment

  def add_coach(coach)
    @coaches << coach if original(@coaches, coach.name, coach.last_name)
  end

  def delete_coach_at(index)
    @coaches.delete_at(index)
  end

  def coach_count
    @coaches.length
  end

  def add_player(players)
    @players << players if original(@players, players.name, players.last_name)
  end

  def delete_player_at(index)
    @players.delete_at(index)
  end

  def player_count
    @players.length
  end

  private

  def original(members, name, last_name)
    members.each do |member|
      if member.name == name && member.last_name == last_name
        return false
      end
    end
    true
  end
end
