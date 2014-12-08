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

def draw_table(deck, ph, dh) #deck, player_hand, dealer_hand
	system 'clear'
	draw_hand(ph)
	draw_hand(dh)
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

def start_player_hand(deck, player_hand)
	player_hand.push(deal_card(deck))
	player_hand.push(deal_card(deck))
end

def start_dealer_hand(deck, dealer_hand) #deck, dealer_hand
	dealer_hand.push(deal_card(deck))
	dealer_hand.push(deal_card(deck))
end

deck = initialize_deck(2, deck)
deck = deck.shuffle

player_hand = start_player_hand(deck, player_hand)
dealer_hand = start_dealer_hand(deck, dealer_hand)

draw_table(deck, player_hand, dealer_hand)

#binding.pry 




