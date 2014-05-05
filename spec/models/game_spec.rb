require 'spec_helper'

describe Game do
  
  let(:game) do
    Game.new()
  end

  def add_players(names)
    names.each { |name| game.players.build(:name => name) }
  end


  describe "#waiting_for_players?" do
    subject { game.waiting_for_players? }
    
    context "when no player is in the game" do 
      it { should be true }
    end  

    context "when just one player entered a game" do 
      before { add_players %w(john) }
      it { should be true }
    end

    context "when two players are in the game" do
      before { add_players %w(john, jim) }
      it { should be false }
    end
  end

  describe "finished?" do
    context "when no player is in the game"
    context "when nobody won yet"
    context "when there is a winner"
  end

  describe "winner" do 
    context "when no player is in the game"
    context "when nobody won yet"
    context "when there is a winner"
  end
    
end
