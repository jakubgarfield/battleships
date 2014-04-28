class Ship < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :presence => true
  validates :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 10 }

  def sunk?
    occupied_points.all { |point| player.opponent.guesses.any? { |guess| guess.coordinate_x == point[0] && guess.coordinate_y == point[1] } }
  end

  def hit?(x, y)
    x_coordinates.include?(x) && y_coordinates.include?(y)
  end

  protected
  def x_coordinates
    self.start_coordinate_x..self.end_coordinate_x
  end
  
  def y_coordinates
    self.start_coordinate_y..self.end_coordinate_y
  end

  def occupied_points
    x_coordinates.flat_map { |x| y_coordinates.map { |y| [x, y] } }
  end
end
