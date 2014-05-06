require 'spec_helper'

describe PlayersController do
  let(:game) { Game.create! }

  describe "#index" do
    subject { get :index, :game_id => game.id }
    it { should be_success }
    it { should render_template("index") }
  end
  
  describe "#show" do
    let(:player) { game.players.create!(:name => "Jakub") }

    subject { get :show, :game_id => game.id, :id => player.id}
    
    context "when game is in progress" do
      it { should render_template("show") }
    end   

    context "when game is finished" do
      before do 
        game.stub(:finished? => true) 
        player.stub(:game => game)
        Player.stub(:find => player)
      end

      it { should redirect_to(game_path(game)) }
    end
  end

  describe "#create" do
    it "creates new player" do
      Player.any_instance.stub(:build_random_ships)
      Player.any_instance.should_receive(:build_random_ships)
      
      expect { post :create, { :game_id => game.id, :player => { :name => "Johny" }}}.to change { Game.count }.by(1)

      player = Player.last
      expect(response).to redirect_to(game_player_path(game, player))
    end
  end

end
