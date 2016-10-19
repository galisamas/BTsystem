require './repo/yaml_repo.rb'
require './entities/owner.rb'
require './ui_helper.rb'

puts 'write your name:'
name = gets.chomp
puts 'write your last name:'
last = gets.chomp

owners = get_all('owner')
index = owners.index { |owner| owner.name == name && owner.last_name == last}

exit if index == nil

while true do
  puts 'Welcome to Basketball Teams\' system'
  puts '------------------------------------'
  puts '1. See my info'
  puts '2. Add/Change email'
  puts '3. Add/Change phone'
  puts '4. Create new team'
  puts '5. Change team name'
  puts '6. Hire coach'
  puts '7. Hire team member'
  puts '8. Fire team member'
  puts '9. Fire coach'
  puts '10. Change coach level'
  puts '0. Exit'

  menu_index = gets.chomp

  case menu_index
    when '1' # See my info
      puts owners[index].to_s
    when '2' # Add/Change email
      menu_email(owners, index)
    when '3' # Add/Change phone
      menu_phone(owners, index)
    when '4' # Create new team
      menu_create_team(owners, index)
    when '5' # Change team name
      menu_change_team_name(owners, index)
    when '6' # Hire coach
      menu_hire_coach(owners, index)
    when '7' # Hire team member
      menu_hire_player(owners, index)
    when '8' # Fire team member
      menu_fire_player(owners, index)
    when '9' # Fire coach
      menu_fire_coach(owners, index)
    when '10' # Change coach level
      menu_change_coach_level(owners, index)
    when '0' # Exit
      exit
    else
      puts 'try again'
      gets
      redo
  end
  puts 'press anything to continue..'
  gets
end
