# Blackjack game

require 'pry'

SINGLE_DECK = [['2', '♠', 2], ['3', '♠', 3], ['4', '♠', 4], ['5', '♠', 5], ['6', '♠', 6], ['7', '♠', 7], ['8', '♠', 8], ['9', '♠', 9], ['10', '♠', 10], ['J', '♠', 10], ['Q', '♠', 10], ['K', '♠', 10], ['A', '♠', [1, 11]], ['2', '♥', 2], ['4', '♥', 4], ['5', '♥', 5], ['6', '♥', 6], ['7', '♥', 7], ['8', '♥', 8], ['9', '♥', 9], ['10', '♥', 10], ['J', '♥', 10], ['Q', '♥', 10], ['K', '♥', 10], ['A', '♥', [1, 11]], ['2', '♦', 2], ['3', '♦', 3], ['4', '♦', 4], ['5', '♦', 5], ['6', '♦', 6], ['7', '♦', 7], ['8', '♦', 8], ['9', '♦', 9], ['10', '♦', 10], ['J', '♦', 10], ['Q', '♦', 10], ['K', '♦', 10], ['A', '♦', [1, 11]], ['2', '♣', 2], ['3', '♣', 3], ['4', '♣', 4], ['5', '♣', 5], ['6', '♣', 6], ['7', '♣', 7], ['8', '♣', 8], ['9', '♣', 9], ['10', '♣', 10], ['J', '♣', 10], ['Q', '♣', 10], ['K', '♣', 10], ['A', '♣', [1, 11]]]
NUMBER_OF_DECKS = 2
deck = Array.new
player_hand = Array.new
dealer_hand = Array.new
  
def initialize_deck(deck) #Integer - number of decks, deck 
  for i in 1..NUMBER_OF_DECKS do
    deck.concat(SINGLE_DECK) 
  end
  return deck
end

def deal_card(deck) #Integer - number of cards, deck
	deck.shift
end

def draw_hand(hand)
	line1 = ""
	line2 = ""
	line3 = ""
	line4 = ""
	hand.each do |card|
		if card[0].length == 1
			line1 << "┌───┐ "
			line2 << "│ #{card[0]} │ "
			line3 << "│ #{card[1]} │ "
			line4 << "└───┘ "
		elsif card[0].length == 2
			line1 << "┌───┐ "
			line2 << "│ #{card[0]}│ "
			line3 << "│ #{card[1]} │ "
			line4 << "└───┘ "
		end			
	end
	puts line1
	puts line2
	puts line3
	puts line4
end

def draw_table(deck, player_hand, dealer_hand) 
	system 'clear'
	draw_hand(dealer_hand)
	draw_hand(player_hand)
	puts "You have #{pretty_hand_total(player_hand, 'player')}. Dealer has #{pretty_hand_total(dealer_hand, 'dealer')}."
	puts ""
end

def check_winner(dealer_hand, player_hand, player_name)
	player_total = get_hand_total(player_hand, true)[0]
  dealer_total = get_hand_total(dealer_hand, true)[0]

  if blackjack?(dealer_hand)
    return "You lost. Better luck next hand #{player_name}."
  elsif  blackjack?(player_hand)
    return "Blackjack! You win!"		
  elsif bust?(player_hand)
    return "Sorry #{player_name}, you busted."
  elsif bust?(dealer_hand)
    return "Dealer busted. You win!"
  elsif player_total > dealer_total
    return "You win, #{player_name}!"
  elsif dealer_total > player_total
    return "You lose."
  elsif player_total == dealer_total
    return "Push."
    
  end
end 

def get_hand_total(hand, final = false) # final = optional Boolean to indicate final hand total
	total = [0, 0]
	hand.each do |card|
		if card[2].kind_of?(Array) #if card is an ace
			if total == [1, 11] #if two aces
				total[0] = 2
				total[1] = 12
			else
				total[0] += card[2][0] #add 1
				total[1] += card[2][1] #add 11
			end
		else
			total[0] += card[2] 
			total[1] += card[2]
		end
    if total[1] > 21
      total[1] = total[0]
    end
	end
  if final
    if total[1] > total[0]
      total[0] = total[1]
    end
  end
	return total
end

def pretty_hand_total(hand, dealer_or_player)
  hand_total = get_hand_total(hand)
  if hand_total[0] == hand_total[1]
    if blackjack?(hand)
      return "Blackjack"
    else
      return "#{hand_total[0]}"
    end
  else
    if blackjack?(hand)
      return "Blackjack"
    elsif dealer_or_player == 'dealer' and hand_total[1] >= 17 #dealer has to stay on soft 17 so just show the higher total
    	return "#{hand_total[1]}"
    else 
      return "#{hand_total[0]} or #{hand_total[1]}"
    end
  end
end

def blackjack?(hand)
  hand_total = get_hand_total(hand)
  if hand_total[0] == 21 or hand_total[1] == 21 and hand.length == 2
    return true
  end
  return false
end

def bust?(hand)
  hand_total = get_hand_total(hand)
	if hand_total[0] > 21 or hand_total[1] > 21
		return true
	end
	return false
end

system 'clear'
puts "Welcome to the Blackjack table. What's your first name?"
player_name = gets.chomp

puts "Thanks for playing, #{player_name}. Good luck. Here we go..."
sleep (1.5)

deck = initialize_deck(deck)
deck = deck.shuffle

begin #continue loop

	player_hand = []
	dealer_hand = []

	player_hand = player_hand.push(deal_card(deck))
	dealer_hand = dealer_hand.push(deal_card(deck))	
	player_hand = player_hand.push(deal_card(deck))
	dealer_hand = dealer_hand.push(deal_card(deck))	

	draw_table(deck, player_hand, dealer_hand)

	if !blackjack?(player_hand) and !blackjack?(dealer_hand)
    begin #player loop

  		begin 
        puts "Stay or Hit? (S/H)"
        choice = gets.chomp
    	end until choice.downcase == 's' || choice.downcase == 'h'

    	if choice == 'h'
    		player_hand.push(deal_card(deck))
    		draw_table(deck, player_hand, dealer_hand)
    	end

  	end until choice == 's' || bust?(player_hand)

    if !bust?(player_hand)
      if get_hand_total(dealer_hand)[1] < 17 #use ace total to make dealer stand on soft 17
        begin #dealer_loop
            dealer_hand.push(deal_card(deck))
            draw_table(deck, player_hand, dealer_hand)
        end until get_hand_total(dealer_hand)[1] >= 17 
      end
    end 

   end 


	puts "#{check_winner(dealer_hand, player_hand, player_name)}"	
	puts ""

	if deck.count < 15
		deck = []
		initialize_deck(deck)
		puts "Time for a new deck..."
		sleep (1)
	end

  puts "Do you want to play again? (Y/N)"
  continue = gets.chomp

end while continue.downcase == 'y'
