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

def menu_hire_coach(users, index)
  nr = -1
  puts 'Your teams'
  users[index].my_teams.each { |team| puts "#{nr += 1}. #{team.name}" }
  puts 'Where to hire coach?'
  chosen_team = gets.chomp
  coaches = get_all('coach')
  coaches.each { |coach| puts "#{nr += 1}. #{coach.name}" }
  puts 'Which one?'
  chosen_coach = gets.chomp
  menu_hire_coach_process(users, index, coaches, chosen_coach, chosen_team)
end
