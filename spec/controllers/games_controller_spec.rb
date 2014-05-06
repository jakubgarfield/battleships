require 'spec_helper'

describe GamesController do
  render_views

  describe "#index" do
    subject { get :index }

    it { should be_success }
    it { should render_template("index") }
  end

  describe "#show" do
    let(:game) { Game.new(:id => 1) }
    before { Game.stub(:find => game) }

    subject { get :show, :id => game.id}
    
    context "when game is in progress" do
      it { should render_template("show") }
    end   

    context "when game is finished" do
      before do 
        game.stub(:finished? => true)
        game.stub(:winner => Player.new(name: "Jakub"))
      end

      it { should render_template("finished") }
    end
  end

  describe "#create" do
    it "creates a new game" do
      expect { post :create, :game => { }}.to change { Game.count }.by(1)

      game = Game.last
      expect(response).to redirect_to(game_players_path(game))
    end
  end
end
