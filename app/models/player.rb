class Player < ActiveRecord::Base
  has_many :ships
  has_many :guesses
  belongs_to :game

  validate :game_id, :name, :presence => true
  validate :name, :allow_blank => false 
  
  AVAILABLE_SHIP_LENGTHS = [5, 4, 3, 2, 2, 1, 1]

  def opponent
    game.players.select { |player| player.id != id }.first
  end

  def turn? 
    opponent.present? && (starts_first_round? || last_guess_correct? || opponent_guess_wrong_and_newer?)
  end

  def won?
    opponent.present? && opponent.ships.all?(&:sunk?)
  end

  def last_guess_correct?
    guesses.any? && guesses.last.correct?
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
  def starts_first_round?
    guesses.none? && created_at < opponent.created_at
  end 

  def opponent_guess_wrong_and_newer?
    opponent.guesses.any? && !opponent.last_guess_correct? && (guesses.none? || guesses.last.created_at < opponent.guesses.last.created_at)
  end

  def free_sea? ship
    !ship.occupied_points.any? do |point| 
      ships.select(&:persisted?).any? { |other_ship| other_ship.occupied_points.include?(point) }
    end
  end
end
