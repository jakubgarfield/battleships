class PlayersController < ApplicationController
  
  def index
    @game = Game.find(params[:game_id])
  end

  def create
    game = Game.find(params[:game_id])
    player = game.players.build(params[:player].permit(:name))

    flash[:error] = player.error.full_messages.to_sentece unless game.save
  end
end
