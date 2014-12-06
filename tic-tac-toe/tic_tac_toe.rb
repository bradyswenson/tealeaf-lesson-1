# Tic Tac Toe game
# 
# flow / logic:
# Draw board
# Player chooses a square
# Computer chooses a square
# Loop until there is a winner or all squares are selected
#
# data structures needed: 
# hash of board positions and contents (empty, X, O)
# hash of arrays player choices and computer choices
# array of winning combinations (to check for winner)

require 'pry'

board_status = {1 => ' ', 2 =>  ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
player_choices = {player: [], computer: []}
winning_combinations = [[1,2,3],[1,5,9],[1,4,7],[2,5,8],[3,5,7],[4,5,6],[7,8,9],[3,6,9]]

def draw_board(bs) #bs = board_status
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

def winner?
  #check to see if player choices match a winning combination
  true
end

begin
  draw_board(board_status)
  #get player input
  #make random computer choice
end until winner?


