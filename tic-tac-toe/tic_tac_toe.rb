# Tic Tac Toe game

require 'pry'

board = Hash.new
winning_combinations = [[1,2,3], [1,5,9], [1,4,7], [2,5,8], [3,5,7], [4,5,6], [7,8,9], [3,6,9]] 
score = {player: 0, computer: 0, tie: 0}

def draw_board(b) #board
  puts "
             |     |
          #{b[1]}  |  #{b[2]}  |  #{b[3]}  
        _____|_____|_____
             |     |
          #{b[4]}  |  #{b[5]}  |  #{b[6]}  
        _____|_____|_____
             |     |
          #{b[7]}  |  #{b[8]}  |  #{b[9]}
             |     |
"
end

def remaining_options(b) #board
  b.keys.select {|position| b[position] == ' '}
end

def get_computer_choice(b, wc) #board, winning_combinations
   wc.each do |combo|
    if b[combo[0]] == 'O' and b[combo[1]] == 'O' and b[combo[2]] == ' '
        return combo[2]
    elsif b[combo[1]] == 'O' and b[combo[2]] == 'O' and b[combo[0]] == ' '
        return combo[0]
    elsif b[combo[0]] == 'O' and b[combo[2]] == 'O' and b[combo[1]] == ' '
        return combo[1]
    elsif b[combo[0]] == 'X' and b[combo[1]] == 'X' and b[combo[2]] == ' '
        return combo[2]
    elsif b[combo[1]] == 'X' and b[combo[2]] == 'X' and b[combo[0]] == ' '
        return combo[0]
    elsif b[combo[0]] == 'X' and b[combo[2]] == 'X' and b[combo[1]] == ' '
        return combo[1]
    end
  end
  if b[5] == ' '
    return 5
  else
    return remaining_options(b).sample
  end
end

def check_winner(b, wc, score) #board, winning_combinations, score
  wc.each do |combo|
    if b[combo[0]] == 'X' and b[combo[1]] == 'X' and b[combo[2]] == 'X'
      score[:player] += 1
      return 'Player'
    elsif b[combo[0]] == 'O' and b[combo[1]] == 'O' and b[combo[2]] == 'O'
      score[:computer] += 1
      return 'Computer' 
    elsif remaining_options(b) == []
      score[:tie] += 1
      return 'Tie'
    end
  end
  return nil
end

begin #continue loop

  #initialize game data
  board = {1 => ' ', 2 =>  ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
  remaining_options = Array(1..9)

  begin #game loop

    draw_board(board)
    
    #get player move
    begin 
      puts "Please choose an unfilled position (1-9) to place your X:"
      player_choice = gets.chomp.to_i
    end until remaining_options.include?(player_choice)

    #track player move
    board[player_choice] = 'X'
    remaining_options.delete(player_choice)

    #check for winner
    winner = check_winner(board, winning_combinations, score)

    #if no winner, get computer move
    if winner == nil 
      comp_choice = get_computer_choice(board, winning_combinations)
      #track computer move
      board[comp_choice] = 'O'
      remaining_options.delete(comp_choice)
      #update winner check
      winner = check_winner(board, winning_combinations, score)
    end

  end until winner == 'Player' || winner == 'Computer' || winner == 'Tie'

  draw_board(board)

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



