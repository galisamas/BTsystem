require './entities/owner.rb'
require './repo/yaml_repo.rb'

def menu_email(users, index)
  begin
    puts 'type new email:'
    email = gets.chomp
    users[index].set_email(email)
    if users[index].contact.email != email then
      puts 'email is incorrect. Try again? [y/else]'
      break if gets.chomp != 'y'
    else
      puts 'email is correct'
      save_all(users, owner_filename)
      break
    end
  end while true
end

def menu_phone(users, index)
  begin
    puts 'type new phone:'
    phone = gets.chomp
    users[index].set_phone(phone)
    if users[index].contact.phone != phone then
      puts 'phone is incorrect. Try again? [y/else]'
      break if gets.chomp != 'y'
    else
      puts 'phone is correct'
      save_all(users, owner_filename)
      break
    end
  end while true
end

def menu_create_team(users, index)
  puts 'type team name:'
  name = gets.chomp
  menu_create_team_process(index, name, users)
end

def menu_change_team_name(users, index)
  nr = -1
  users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
  puts 'Which one?'
  chosen_nr = gets.chomp
  puts 'your new name:'
  new_name = gets.chomp
  menu_change_team_name_process(chosen_nr, index, new_name, users)
end

@coach_filename = 'coach'
@player_filename = 'player'
def menu_hire_coach(users, index)
  coaches = get_all(@coach_filename)
  unless coaches.empty?
    nr = -1
    puts 'Your teams'
    users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
    puts 'Choose team number?'
    chosen_team = gets.chomp
    nr = -1
    coaches.each { |coach| puts "#{nr += 1}. #{coach.name}" }
    puts 'Which one?'
    chosen_coach = gets.chomp
    menu_hire_coach_process(users, index, coaches, chosen_coach.to_i, chosen_team.to_i)
  else
    puts 'Nothing to hire'
  end
end

def menu_fire_coach(users, index)
  nr = -1
  puts 'Your teams'
  users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
  puts 'Choose team number?'
  chosen_team = gets.chomp
  choaches = users[index].my_teams[chosen_team.to_i].coaches
  if choaches.empty?
    puts 'No coaches in this team'
  else
    nr = -1
    choaches.each { |coach| puts "#{nr += 1}. #{coach.name}" }
    puts 'Which one?'
    chosen_coach = gets.chomp
    coaches = get_all(@coach_filename)
    menu_fire_coach_process(users, index, coaches, chosen_coach.to_i, chosen_team.to_i)
  end
end

def menu_hire_player(users, index)
  players = get_all(@player_filename)
  unless players.empty?
    nr = -1
    puts 'Your teams'
    users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
    puts 'Choose team number?'
    chosen_team = gets.chomp
    nr = -1
    players.each { |player| puts "#{nr += 1}. #{player.name}" }
    puts 'Which one?'
    chosen_player = gets.chomp
    menu_hire_player_process(users, index, players, chosen_player.to_i, chosen_team.to_i)
  else
    puts 'Nothing to hire'
  end
end

def menu_fire_player(users, index)
  nr = -1
  puts 'Your teams'
  users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
  puts 'Choose team number?'
  chosen_team = gets.chomp
  players = users[index].my_teams[chosen_team.to_i].players
  if players.empty?
    puts 'No players in this team'
  else
    nr = -1
    players.each { |player| puts "#{nr += 1}. #{player.name}" }
    puts 'Which one?'
    chosen_player = gets.chomp
    players = get_all(@player_filename)
    menu_fire_player_process(users, index, players, chosen_player.to_i, chosen_team.to_i)
  end
end

def menu_change_coach_level(users, index)
  levels = [ 'head', 'second', 'assistant', 'scout' ]
  nr = -1
  puts 'Your teams'
  users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
  puts 'Choose team number?'
  chosen_team = gets.chomp
  coaches = users[index].my_teams[chosen_team.to_i].coaches
  unless coaches.empty?
    nr = -1
    coaches.each { |coach| puts "#{nr += 1}. #{coach.name}" }
    puts 'Which one?'
    chosen_coach = gets.chomp
    nr = -1
    levels.each { |level| puts "#{nr += 1}. #{level}" }
    puts 'Choose level?'
    chosen_level = gets.chomp
    level = levels[chosen_level.to_i]
    menu_change_coach_level_process(users, index, chosen_coach.to_i, chosen_team.to_i, level)
  else
    puts 'No coaches in this team'
  end
end
