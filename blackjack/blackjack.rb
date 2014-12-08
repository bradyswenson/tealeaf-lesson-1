# Blackjack game

require 'pry'

SINGLE_DECK = [['2', '♠', 2], ['3', '♠', 3], ['4', '♠', 4], ['5', '♠', 5], ['6', '♠', 6], ['7', '♠', 7], ['8', '♠', 8], ['9', '♠', 9], ['10', '♠', 10], ['J', '♠', 10], ['Q', '♠', 10], ['K', '♠', 10], ['A', '♠', [1, 11]], ['2', '♥', 2], ['4', '♥', 4], ['5', '♥', 5], ['6', '♥', 6], ['7', '♥', 7], ['8', '♥', 8], ['9', '♥', 9], ['10', '♥', 10], ['J', '♥', 10], ['Q', '♥', 10], ['K', '♥', 10], ['A', '♥', [1, 11]], ['2', '♦', 2], ['3', '♦', 3], ['4', '♦', 4], ['5', '♦', 5], ['6', '♦', 6], ['7', '♦', 7], ['8', '♦', 8], ['9', '♦', 9], ['10', '♦', 10], ['J', '♦', 10], ['Q', '♦', 10], ['K', '♦', 10], ['A', '♦', [1, 11]], ['2', '♣', 2], ['3', '♣', 3], ['4', '♣', 4], ['5', '♣', 5], ['6', '♣', 6], ['7', '♣', 7], ['8', '♣', 8], ['9', '♣', 9], ['10', '♣', 10], ['J', '♣', 10], ['Q', '♣', 10], ['K', '♣', 10], ['A', '♣', [1, 11]]]
deck = Array.new
player_hand = Array.new
dealer_hand = Array.new
  
def initialize_deck(num, deck) #Integer - number of decks, deck 
  for i in 1..num do
    deck.concat(SINGLE_DECK) 
  end
  return deck
end

def deal_card(deck) #Integer - number of cards, deck
	card = deck.shift
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
	#binding.pry
	puts "Player has #{pretty_hand_total(player_hand)}. Dealer has #{pretty_hand_total(dealer_hand)}."
end

def start_player_hand(deck, player_hand)
	player_hand.push(deal_card(deck))
	player_hand.push(deal_card(deck))
end

def start_dealer_hand(deck, dealer_hand) 
	dealer_hand.push(deal_card(deck))
	dealer_hand.push(deal_card(deck))
end

def check_winner(dealer_hand, player_hand)
	player_total = get_hand_total(player_hand, 1)[0]
  dealer_total = get_hand_total(dealer_hand, 1)[0]

  if blackjack?(dealer_hand)
    return 'You lose.'
  elsif  blackjack?(player_hand)
    return 'Blackjack! You win!'
  elsif player_total == 21
    return 'You win!'
  elsif bust?(player_hand)
    return 'You busted.'
  elsif bust?(dealer_hand)
    return 'Dealer busted. You win!'
  elsif player_total > dealer_total
    return 'You win!'
  elsif dealer_total > player_total
    return 'You lose.'
  elsif player_total == dealer_total
    return 'Push.'
    
  end
end 

def get_hand_total(hand, *final) # final = optional Boolean to indicate final hand total
	total = [0, 0]
	hand.each do |card|
		if card[2].kind_of?(Array)
			total[0] += card[2][0]
			total[1] += card[2][1]
		else
			total[0] += card[2]
			total[1] += card[2]
		end
    if total[1] > 21
      total[1] = total[0]
    end
	end
  if final == [1]
    #binding.pry
    if total[1] > total[0]
      total[0] = total[1]
    end
  end
  #add exception for 2 aces, should return [2, 13]
  #add exception for dealer, has to stay on 17+ with an ace, if total[1] >= 17, set both to total[1]
	return total
end

def pretty_hand_total(hand)
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

begin #continue loop

	deck = initialize_deck(2, deck)
	deck = deck.shuffle

	player_hand = []
	dealer_hand = []

	player_hand = start_player_hand(deck, player_hand)
	dealer_hand = start_dealer_hand(deck, dealer_hand)	

	draw_table(deck, player_hand, dealer_hand)

  #binding.pry

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

        #binding.pry

  	end until choice == 's' || bust?(player_hand) == true

    if !bust?(player_hand)
      if get_hand_total(dealer_hand)[0] < 17 
        begin #dealer_loop
            dealer_hand.push(deal_card(deck))
            draw_table(deck, player_hand, dealer_hand)
        end until get_hand_total(dealer_hand)[0] >= 17 
      end
    end 

   end 


	puts "#{check_winner(dealer_hand, player_hand)}"	


  puts "Do you want to play again? (Y/N)"
  continue = gets.chomp

end while continue.downcase == 'y'


#binding.pry 




