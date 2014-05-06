class PlayersController < ApplicationController
  
  def index
    @game = Game.find(params[:game_id])
  end

  def show
    @player = Player.find(params[:id])
    redirect_to game_path(@player.game) if @player.game.finished?
  end

  def create
    game = Game.find(params[:game_id])
    
    player = game.players.build(params[:player].permit(:name))
    player.build_random_ships
    player.save!
    
    flash[:error] = player.errors.full_messages.to_sentence unless game.save
    redirect_to game_player_path(game, player)
  end
end
