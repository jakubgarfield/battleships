class Game < ActiveRecord::Base
  has_many :players
  accepts_nested_attributes_for :players 

  def finished?
    winner.nil?
  end

  def waiting_for_players?
    self.players.length < 2
  end

  def winner
    self.players.first(&:won)
  end

end
