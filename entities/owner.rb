require './entities/team.rb'
require './entities/coach.rb'
require './entities/person.rb'

# This is Person's inhereted Owner class
class Owner < Person
  def initialize(name, last_name, gender)
    super(name, last_name, gender)
    @my_teams = []
  end

  attr_reader :my_teams

  def to_s
    info_a = "I'm #{name} #{last_name}, #{gender} and I have "
    info_b = "#{owned_team_count} team(s). Contacts: #{@contact.email} #{@contact.phone}."
    info_a + info_b
  end

  def create_team(team_name)
    @my_teams << Team.new(team_name, self)
  end

  def newest_team
    @my_teams.last
  end

  def change_team_name(old_name, new_name)
    get_team_by_name(old_name).name = new_name
  end

  def owned_team_count
    @my_teams.length
  end

  def hire_coach(team_name, coach)
    get_team_by_name(team_name).add_coach(coach)
  end

  def team_coach_count(team_name)
    get_team_by_name(team_name).coach_count
  end

  private

  def get_team_by_name(name)
    index = @my_teams.find_index { |team| team.name == name }
    @my_teams[index]
  end
end
