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
