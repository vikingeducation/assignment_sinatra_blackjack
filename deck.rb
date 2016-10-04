require 'pry-byebug'

class Deck

	attr_reader :deck
	attr_accessor :player_cards, :dealer_cards


	def initialize( deck = nil, player_cards = [], dealer_cards = [] )

		@player_cards = player_cards
		@dealer_cards = dealer_cards


		if deck

			@deck = deck

		elsif !deck

			@deck = [ "A", "A", "A", "A",
							"2", "2", "2", "2",
							"3", "3", "3", "3",
							"4", "4", "4", "4",
							"5", "5", "5", "5",
							"6", "6", "6", "6",
							"7", "7", "7", "7",
							"8", "8", "8", "8",
							"9", "9", "9", "9",
							"10","10","10","10",
							"J", "J", "J", "J",
							"Q", "Q", "Q", "Q",
							"K", "K", "K", "K" ]

			shuffle
			deal


		end

		if player_cards == [] && deck

			deal

		end


	end


	def evaluate_cards( hand )

		# hand is sorted then reversed to put the Ace last
		# then the Ace is evaluated to be 1 or 11 based on result
		int_hand = hand.map { | card | to_int( card ) }.sort.reverse

		hand_total = add_cards( int_hand )

	end


	def add_cards( hand )

		hand.inject( 0 ) do | r, e |

		  # main logic for dealing with Aces
			if e == 1

				if ( r + 11 ) > 21

					r += e

				else

					r += 11

				end

			else
				# if not an Ace it is added to total
				r += e

			end

		end



	end


	def to_int( card )

		if ( "10,J,Q,K" ).include?( card )

			card = 10

		elsif ( "2,3,4,5,6,7,8,9" ).include?( card )

			card.to_i

		elsif card == "A"

			card = 1

		end


	end


	def shuffle

		@deck.shuffle!

	end


	def deal

		new_deck?

		@player_cards += @deck.pop( 2 )
		@dealer_cards += @deck.pop( 2 )

	end


	def new_deck?
binding.pry
		if @deck.count == 1

			self.new( nil, @player_cards, @dealer_cards )

		end

	end


	def hit

		@deck.pop( 1 )

	end



end