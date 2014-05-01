class Player < ActiveRecord::Base
  has_many :ships
  has_many :guesses
  belongs_to :game

  validate :game_id, :name, :active, :presence => true
  validate :name, :allow_blank => false 
  
  SHIPS = [5, 4, 3, 2, 2, 1, 1]

  def generate_ships
    SHIPS.each(&:place_ship_randomly)
  end

  def opponent
    game.players.select { |i| i.id != id }.first
  end

  def won?
    opponent.ships.all(&:sunk?)
  end

  def can_place_ship?(ship)
    [ship.start_coordinate_x, ship.start_coordinate_y, ship.end_coordinate_x, ship.end_coordinate_y].all(&:coordinate_in_range?)
    && !ship.occupied_points.any? { |point| self.ships.occupied_points.include?(point) }
  end

  protected
  def place_ship_randomly(length)   
    ship = Ship.random until can_place_ship?(ship)
    self.ships << ship
    self.save!
  end

  def compute_ending_coordinate(start, length)
    start + length - 1
  end

  def coordinate_in_range?(coordinate)
    coordinate < Game.CANVAS_SIZE && coordinate >= 0
  end
end
