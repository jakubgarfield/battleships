class Guess < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :coordinate_x, :coordinate_y, :presence => true
  validates :coordinate_x, :coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => Game::CANVAS_SIZE }

  def correct?
    player.opponent.ships.any? { |ship| ship.hit?(self.coordinate_x, self.coordinate_y) }   
  end

end
