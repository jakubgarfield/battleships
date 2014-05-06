class Game < ActiveRecord::Base
  has_many :players
  accepts_nested_attributes_for :players 

  CANVAS_SIZE = 10

  def finished?
    winner.present?
  end

  def waiting_for_players?
    players.length < 2
  end

  def winner
    players.find(&:won?)
  end

end
