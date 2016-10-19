require 'yaml'

def get_all(name)
  YAML.load_file("./config/#{name}.yml")
end

def save_all(owners, filename)
  File.open("./config/#{filename}.yml", 'w') {|file| file.write(YAML::dump(owners))}
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
