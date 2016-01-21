require 'sinatra'
require 'thin'
require 'byebug'
require 'pp'
require 'json'
# require 'sinatra/reloader' if development?
require './helpers/blackjack'

enable :sessions

get '/' do
  game = Blackjack.new
  session['player_deck'] = game.player_cards.to_json
  session['dealer_deck'] = game.dealer_cards.to_json
  session['main_deck'] = game.deck.to_json

  erb :index

end

post '/' do
  redirect to('/blackjack')
end

get '/blackjack' do
  game = Blackjack.new
  player_deck = JSON.parse( session[:player_deck] )
  dealer_deck = JSON.parse( session[:dealer_deck] )
  deck = JSON.parse( session[:main_deck] )
  erb :blackjack, :locals => {:player_deck => player_deck, :dealer_deck => dealer_deck}
end

post '/blackjack' do
  player_deck = JSON.parse( session[:player_deck] )
  dealer_deck = JSON.parse( session[:dealer_deck] )
  deck = JSON.parse( session[:main_deck] )
  
  game = Blackjack.new(deck, player_deck, dealer_deck)
  
  session['player_deck'] = game.player_cards.to_json
  session['dealer_deck'] = game.dealer_cards.to_json
  session['main_deck'] = game.deck.to_json

    # if params[:player_action] == 'Hit'
    #   game.deal_card(player_deck)
    #   session['player_deck'] = game.player_cards.to_json
    #   session['main_deck'] = game.deck.to_json
    #   print "Player Lost!" if game.lost?(player_deck)

    # elsif params[:player_action] == 'Stay'
    #   game.deal_card(dealer_deck)
    #   session['dealer_deck'] = game.dealer_cards.to_json
    #   session['main_deck'] = game.deck.to_json
    #   print "Dealer Lost!" if game.lost?(dealer_deck)
    # end

    # player_deck = JSON.parse( session[:player_deck] )
    # dealer_deck = JSON.parse( session[:dealer_deck] )
    # deck = JSON.parse( session[:main_deck] )

    erb :blackjack, :locals => {:player_deck => player_deck, :dealer_deck => dealer_deck}

end

get '/blackjack/hit' do

  player_deck = JSON.parse( session[:player_deck] )
  dealer_deck = JSON.parse( session[:dealer_deck] )
  deck = JSON.parse( session[:main_deck] )

  game = Blackjack.new(deck, player_deck, dealer_deck)
  
  game.deal_card(player_deck)

  session['player_deck'] = game.player_cards.to_json
  session['main_deck'] = game.deck.to_json
  print "Player Lost!" if game.lost?(player_deck)

  erb :blackjack, :locals => {:player_deck => player_deck, :dealer_deck => dealer_deck}

end
