class PlayersController < ApplicationController
  
  def index
    @game = Game.find(params[:game_id])
  end

  def show
    @player = Player.find(params[:id])
  end

  def create
    game = Game.find(params[:game_id])
    
    player = game.players.build(params[:player].permit(:name))
    player.active = game.players.length < 2
    player.save!
    
    generate_random_ships(player)

    flash[:error] = player.errors.full_messages.to_sentence unless game.save
    redirect_to game_player_path(game, player)
  end

  protected
  def generate_random_ships(player)
    Player::SHIPS.each do |length| 
      ship = player.ships.build
      ship.randomize(length) until player.can_place_ship?(ship)
      ship.save!
    end
  end
end
