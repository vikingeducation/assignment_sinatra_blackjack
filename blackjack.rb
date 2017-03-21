# The objective of the game is to beat the dealer in one of the following ways:
#
# - Get 21 points on the player's first two cards (called a "blackjack" or
# "natural"), without a dealer blackjack;
# - Reach a final score higher than the dealer without exceeding 21; or
# - Let the dealer draw additional cards until his or her hand exceeds 21.

# Rules
# - The players are dealt two cards and add together the value of their cards.
# - Face cards (kings, queens, and jacks) are counted as ten points
# - A player and the dealer can count an ace as 1 point or 11 points
# - All other cards are counted as the numeric value shown on the card
# - The playerwins by having a score of 21 or by having the higher score
# that is less than 21
# - Scoring higher than 21 results in a loss

class Blackjack
  attr_accessor :deck, :p1, :p2

  Card = Struct.new("Card", :suit, :rank)
  Player = Struct.new("Player", :cards)
  SUITS = [:clubs, :diamonds, :hearts, :spades]
  RANKS = (2..10).to_a + [:ace, :jack, :queen, :king]

  def initialize
    @deck = make_deck.flatten!.shuffle
    @p1 = Player.new([])
    @p2 = Player.new([])
  end

  def make_deck
    SUITS.map do |s|
      RANKS.map do |r|
        Card.new(s, r)
      end
    end
  end

  def deal_card(p)
    card = deck.pop
    p1.card.push(card)
  end

  def check_score(cards)
    cards.map do |card|
      if card.is_a? Symbol
        card == :ace ? (cards.count > 2 ? 1 : 11) : 10
      else
        card
      end
    end
  end

end
