# Tic Tac Toe game

require 'pry'

board_status = Hash.new
remaining_options = Array.new
winning_combinations = [[1,2,3], [1,5,9], [1,4,7], [2,5,8], [3,5,7], [4,5,6], [7,8,9], [3,6,9]] 
score = {player: 0, computer: 0, tie: 0}

def draw_board(bs) #board_status
  puts "
             |     |
          #{bs[1]}  |  #{bs[2]}  |  #{bs[3]}  
        _____|_____|_____
             |     |
          #{bs[4]}  |  #{bs[5]}  |  #{bs[6]}  
        _____|_____|_____
             |     |
          #{bs[7]}  |  #{bs[8]}  |  #{bs[9]}
             |     |
"
end

def get_computer_choice(bs, ro, wc) #board_status, remaining_options, winning_combinations
   wc.each do |combo|
    if bs[combo[0]] == 'O' and bs[combo[1]] == 'O' and bs[combo[2]] == ' '
        return combo[2]
    elsif bs[combo[1]] == 'O' and bs[combo[2]] == 'O' and bs[combo[0]] == ' '
        return combo[0]
    elsif bs[combo[0]] == 'O' and bs[combo[2]] == 'O' and bs[combo[1]] == ' '
        return combo[1]
    elsif bs[combo[0]] == 'X' and bs[combo[1]] == 'X' and bs[combo[2]] == ' '
        return combo[2]
    elsif bs[combo[1]] == 'X' and bs[combo[2]] == 'X' and bs[combo[0]] == ' '
        return combo[0]
    elsif bs[combo[0]] == 'X' and bs[combo[2]] == 'X' and bs[combo[1]] == ' '
        return combo[1]
    end
  end
  if bs[5] == ' '
    return 5
  else
    return ro.sample
  end
end

def check_winner(bs, wc, ro, score) #board_status, winning_combinations, remaining_options, score
  wc.each do |combo|
    if bs[combo[0]] == 'X' and bs[combo[1]] == 'X' and bs[combo[2]] == 'X'
      score[:player] += 1
      return 'Player'
    elsif bs[combo[0]] == 'O' and bs[combo[1]] == 'O' and bs[combo[2]] == 'O'
      score[:computer] += 1
      return 'Computer' 
    elsif ro == []
      score[:tie] += 1
      return 'Tie'
    end
  end
  return nil
end

begin #continue loop

  #initialize game data
  board_status = {1 => ' ', 2 =>  ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
  remaining_options = Array(1..9)

  begin #game loop

    draw_board(board_status)
    
    #get player move
    begin 
      puts "Please choose an unfilled position (1-9) to place your X:"
      player_choice = gets.chomp.to_i
    end until remaining_options.include?(player_choice)

    #track player move
    board_status[player_choice] = 'X'
    remaining_options.delete(player_choice)

    #check for winner
    winner = check_winner(board_status, winning_combinations, remaining_options, score)

    #if no winner, get computer move
    if winner == nil 
      comp_choice = get_computer_choice(board_status, remaining_options, winning_combinations)
      #track computer move
      board_status[comp_choice] = 'O'
      remaining_options.delete(comp_choice)
      #update winner check
      winner = check_winner(board_status, winning_combinations, remaining_options, score)
    end

  end until winner == 'Player' || winner == 'Computer' || winner == 'Tie'

  draw_board(board_status)

  if winner == 'Player' 
    puts "You won!"
  elsif winner == 'Computer'
    puts "You lost."
  elsif winner == 'Tie'
    puts "Tie."
  end

  puts "Player: #{score[:player]} -- Computer: #{score[:computer]} -- Ties: #{score[:tie]}"
  puts "Do you want to play again? (Y/N)"
  continue = gets.chomp

end while continue.downcase == 'y'

puts "Thanks for playing!"



