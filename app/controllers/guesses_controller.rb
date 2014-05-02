class GuessesController < ApplicationController
  def create
    player = Player.find(params[:player_id])
    guess = player.guesses.build(params[:guess].permit(:coordinate_x, :coordinate_y))

    flash[:error] = guess.errors.full_messages.to_sentence unless player.save
    redirect_to game_player_path(player.game, player)
  end
end
