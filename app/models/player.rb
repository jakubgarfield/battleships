class Player < ActiveRecord::Base
  has_many :ships
  has_many :guesses
  belongs_to :game

  validate :game_id, :name, :active, :presence => true
  validate :name, :allow_blank => false 
  
  SHIPS = [5, 4, 3, 2, 2, 1, 1]

  def opponent
    game.players.select { |i| i.id != id }.first
  end

  def won?
    opponent.ships.all(&:sunk?)
  end

  def can_place_ship?(ship)
    coordinates_in_range?(ship) && free_sea?(ship)
  end

  protected
  def place_ship_randomly(length)   
    ship = self.ships.build
    ship.randomize(length) until can_place_ship?(ship)
    self.save!
  end

  def coordinate_in_range?(coordinate)
    coordinate && coordinate < Game::CANVAS_SIZE && coordinate >= 0
  end

  def coordinates_in_range?(ship)
    [ship.start_coordinate_x, ship.start_coordinate_y, ship.end_coordinate_x, ship.end_coordinate_y].all? { |coordinate| coordinate_in_range?(coordinate) }
  end

  def free_sea? ship
    !ship.occupied_points.any? { |point| self.ships.select(&:persisted?).any? { |other_ship| other_ship.occupied_points.include?(point) } } 
  end
end
