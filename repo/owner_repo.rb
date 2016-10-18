require 'yaml'

def get_all(name)
  YAML.load_file("./config/#{name}.yml")
end

def save_owners(owners, filename)
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