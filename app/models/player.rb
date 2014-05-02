class Player < ActiveRecord::Base
  has_many :ships
  has_many :guesses
  belongs_to :game

  validate :game_id, :name, :presence => true
  validate :name, :allow_blank => false 
  
  AVAILABLE_SHIP_LENGTHS = [5, 4, 3, 2, 2, 1, 1]

  def opponent
    game.players.select { |i| i.id != id }.first
  end

  def turn? 
    (guesses.any? && guesses.last.correct?) || (guesses.none? && id < opponent.id)
  end

  def won?
    opponent && opponent.ships.all?(&:sunk?)
  end

  def can_place_ship?(ship)
    ship.coordinates_in_range? && free_sea?(ship)
  end

  def build_random_ships
    AVAILABLE_SHIP_LENGTHS.each do |length| 
      ship = ships.build
      ship.randomize(length) until can_place_ship?(ship)
    end
  end

  
  protected

  def free_sea? ship
    !ship.occupied_points.any? do |point| 
      ships.select(&:persisted?).any? { |other_ship| other_ship.occupied_points.include?(point) }
    end
  end
end
