class Game < ActiveRecord::Base
  has_many :players

  def finished?
    winner.nil?
  end

  def winner
    self.players.first(&:won)
  end

end
