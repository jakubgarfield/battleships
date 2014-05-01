class PlayersController < ApplicationController
  
  def index
    @game = Game.find(params[:game_id])
  end

  def show
    player = Player.find(params[:id])
  end

  def create
    game = Game.find(params[:game_id])
    player = game.players.build(params[:player].permit(:name))
    player.generate_ships

    flash[:error] = player.error.full_messages.to_sentece unless game.save
  end
end
