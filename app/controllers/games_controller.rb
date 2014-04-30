class GamesController < ApplicationController
  def index
    @joinable_games = Game.all.select(&:waiting_for_players?)
    @game = Game.new
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to game_players_path(@game)  
    else
      render 'index'
    end
  end

  def show
    @game = Game.find(params[:id])
    render "finished" if @game.finished?
  end

end
