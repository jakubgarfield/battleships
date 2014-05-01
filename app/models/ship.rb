class Ship < ActiveRecord::Base
  belongs_to :player

  validates :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :presence => true
  validates :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 10 }

  def randomize(length)
    self.start_coordinate_x = rand(10)
    self.start_coordinate_y = rand(10)
    is_vertical = rand(2) == 0
    self.end_coordinate_x = is_vertical ? start_coordinate_x : ending_coordinate(start_coordinate_x, length)
    self.end_coordinate_y = is_vertical ? ending_coordinate(start_coordinate_y, length) : start_coordinate_y 
  end

  def sunk?
    occupied_points.all? { |point| player.opponent.guesses.any? { |guess| guess.coordinate_x == point[0] && guess.coordinate_y == point[1] } }
  end

  def hit?(x, y)
    x_coordinates.include?(x) && y_coordinates.include?(y)
  end

  def occupied_points
    x_coordinates.flat_map { |x| y_coordinates.map { |y| [x, y] } }
  end

  def coordinates_in_range?
    [start_coordinate_x, start_coordinate_y, end_coordinate_x, end_coordinate_y].all? { |coordinate| coordinate_in_range?(coordinate) }
  end


  protected
  def x_coordinates
    start_coordinate_x..end_coordinate_x
  end
  
  def y_coordinates
    start_coordinate_y..end_coordinate_y
  end

  def ending_coordinate(start, length)
    start + length - 1
  end

  def coordinate_in_range?(coordinate)
    coordinate && coordinate < Game::CANVAS_SIZE && coordinate >= 0
  end
end
