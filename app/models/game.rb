class Game < ActiveRecord::Base
  has_many :players

  def finished?
    winner.nil?
  end

  def waiting_for_opponent?
    self.players.length < 2
  end

  def winner
    self.players.first(&:won)
  end

end
