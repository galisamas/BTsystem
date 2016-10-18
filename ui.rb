require './repo/owner_repo.rb'
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
  puts '10. Change coach status'
  puts '11. Send message'
  puts '12. See messages'
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
    when '7' # Hire team member
    when '8' # Fire team member
    when '9' # Fire coach
    when '10' # Change coach status
    when '11' # Send message
    when '12' # See messages
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
