# PAPER ROCK SCISSORS GAME
require 'pry'

choices = ['p', 'r', 's']

puts "Let's Rochambeau!"

begin

  puts "Choose Paper, Rock or Scissors (P/R/S):"

  player_choice = gets.chomp

  while !choices.include?player_choice do  
    puts "You must enter P, R or S. Please try again (P/R/S):"
    player_choice = gets.chomp
  end

  comp_choice = choices.sample

  case player_choice.downcase
  when 'p'
    case comp_choice
    when 'p'
      puts "You and the computer both chose paper. Push."
    when 'r'
      puts "Your paper covers computer's rock. You win!"
    when 's'
      puts "Computer's scissors cut your paper. You lose."
    end
  when 'r'
    case comp_choice
    when 'p'
      puts "Computer's paper covers your rock. You lose."
    when 'r'
      puts "You and the computer both chose rock. Push."
    when 's'
      puts "Your rock smashes computer's scissors. You win!"
    end
  when 's'
    case comp_choice
    when 'p'
      puts "Your scissors cut computer's paper. You win!"
    when 'r'
      puts "Computer's rock smashes your scissors. You lose."
    when 's'
      puts "You and the computer both chose scissors. Push."
    end
  end
    
  puts "Do you want to play again? (Y/N)"
  continue = gets.chomp

end while continue.downcase == 'y'

puts "Thanks for playing!"