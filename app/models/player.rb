class Player < ActiveRecord::Base
  has_many :ships
  has_many :guesses
  belongs_to :game

  validate :game_id, :name, :presence => true
  validate :name, :allow_blank => false 

  def opponent
    game.players.select { |i| i.id != id }.first
  end

  def won?
    opponent.ships.all(&:sunk?)
  end

end
