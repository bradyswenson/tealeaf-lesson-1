# Tic Tac Toe game
# 
# flow / logic:
# Draw board
# Player chooses a square
# Computer chooses a square
# Loop until there is a winner or all squares are selected
#
# data structures: 
# hash of board positions and contents (empty, X, O)
# hash of arrays player choices and computer choices
# array of remaining options
# array of winning combinations (to check for winner)

require 'pry'

board_status = {1 => ' ', 2 =>  ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
remaining_options = Array(1..9)
player_status = {player: [], computer: []}
winning_combinations = [[1,2,3],[1,5,9],[1,4,7],[2,5,8],[3,5,7],[4,5,6],[7,8,9],[3,6,9]]

def draw_board(bs) #bs = board_status hash
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

def winner?(winning_combinations, player_status)
  if winning_combinations.include?(player_status[:player]) 
    return "You win!"
  elsif winning_combinations.include?(player_status[:computer])  
    return "Computer wins."
  end
end

begin

  board_status = {1 => ' ', 2 =>  ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
  remaining_options = Array(1..9)
  player_status = {player: [], computer: []}
  winning_combinations = [[1,2,3],[1,5,9],[1,4,7],[2,5,8],[3,5,7],[4,5,6],[7,8,9],[3,6,9]]


  begin
    draw_board(board_status)
    
    #get player input
    begin 
      puts "Please choose an unfilled position (1-9) to place your X:"
      player_choice = gets.chomp.to_i
    end until remaining_options.include?(player_choice)

    board_status[player_choice] = 'X'
    player_status[:player].push(player_choice)
    remaining_options.delete(player_choice)

    computer_choice = remaining_options.sample

    board_status[computer_choice] = 'O'
    player_status[:computer].push(computer_choice)
    remaining_options.delete(computer_choice)


   # binding.pry

    #make random computer choice
  end until winner?(winning_combinations, player_status)

  draw_board(board_status)
  puts winner?(winning_combinations, player_status)

  puts "Do you want to play again? (Y/N)"
  continue = gets.chomp

end while continue.downcase == 'y'





