require 'yaml'
require './entities/owner.rb'

def get_all(name)
  YAML.load_file("./config/#{name}.yml")
end

def save_all(array, filename)
  File.open("./config/#{filename}.yml", 'w') {|file| file.write(YAML::dump(array))}
end

def original(owners, name)
  owners.each do |user|
    if user.my_teams.any?{|team| team.name == name}
      return false
    end
  end
  true
end

@owner_filename = 'owner'
@coach_filename = 'coach'
@player_filename = 'player'
def menu_create_team_process(index, name, users)
  if original(users, name)
    users[index].create_team(name)
    save_all(users, @owner_filename)
    puts 'team was successfully added'
  else
    puts "team name #{name} already exist"
  end
end

def menu_change_team_name_process(chosen_nr, index, new_name, users)
  if original(users, new_name)
    users[index].change_team_name(users[index].my_teams[chosen_nr.to_i].name, new_name)
    save_all(users, @owner_filename)
    puts "team name was successfully changed to #{new_name}"
  else
    puts "team name #{new_name} already exist"
  end
end

def menu_hire_coach_process(users, index, coaches, chosen_coach, chosen_team)
  old_size = users[index].my_teams[chosen_team].coaches.size
  team_name = users[index].my_teams[chosen_team].name
  users[index].hire_coach(team_name, coaches[chosen_coach])
  if(old_size < users[index].my_teams[chosen_team].coaches.size)
    coach_name = coaches[chosen_coach].name
    coaches.delete_at(chosen_coach)
    save_all(coaches, @coach_filename)
    save_all(users, @owner_filename)
    puts "#{coach_name} was successfully hired"
  else
    puts "#{coaches[chosen_coach].name} is already #{team_name}'s coach"
  end
end

def menu_fire_coach_process(users, index, coaches, chosen_coach, chosen_team)
  old_size = users[index].my_teams[chosen_team].coaches.size
  team_name = users[index].my_teams[chosen_team].name
  deteled_coach = users[index].my_teams[chosen_team].coaches[chosen_coach]
  users[index].fire_coach(team_name, chosen_coach)
  coaches.push(deteled_coach)
  save_all(coaches, @coach_filename)
  save_all(users, @owner_filename)
  puts "#{deteled_coach.name} was successfully fired"
end

def menu_hire_player_process(users, index, players, chosen_player, chosen_team)
  old_size = users[index].my_teams[chosen_team].players.size
  team_name = users[index].my_teams[chosen_team].name
  users[index].hire_player(team_name, players[chosen_player])
  if(old_size < users[index].my_teams[chosen_team].players.size)
    player_name = players[chosen_player].name
    players.delete_at(chosen_player)
    save_all(players, @player_filename)
    save_all(users, @owner_filename)
    puts "#{player_name} was successfully hired"
  else
    puts "#{players[chosen_player].name} is already #{team_name}'s player"
  end
end

def menu_fire_player_process(users, index, players, chosen_player, chosen_team)
  old_size = users[index].my_teams[chosen_team].players.size
  team_name = users[index].my_teams[chosen_team].name
  deteled_player = users[index].my_teams[chosen_team].players[chosen_player]
  users[index].fire_player(team_name, chosen_player)
  players.push(deteled_player)
  save_all(players, @player_filename)
  save_all(users, @owner_filename)
  puts "#{deteled_player.name} was successfully fired"
end

