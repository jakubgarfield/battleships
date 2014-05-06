require 'spec_helper'

describe GuessesController do
  describe "#create" do
    let(:game) { Game.create! }
    let(:player) { game.players.create!(:name => "Johny") }
    let(:create_parameters) {{ :game_id => game.id, :player_id => player.id, :guess => { :coordinate_x => 6, :coordinate_y => 4 }}}
    
    it "should add a new guess" do
      expect { post :create, create_parameters }.to change { Guess.count }.by(1)
      guess = Guess.last
      expect(response).to redirect_to(game_player_path(guess.player.game, guess.player))
    end
     
    it "should add a guess and redirect to a game view when game is won" do
      Player.stub(:find => player)
      player.stub(:won? => true) 

      expect { post :create, create_parameters }.to change { Guess.count }.by(1)
      expect(response).to redirect_to(game_path(game))
    end

  end
end
