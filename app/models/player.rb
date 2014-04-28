class Player < ActiveRecord::Base
  belongs_to :game

  validate :game_id, :name, :presence => true
  validate :name, :allow_blank => false 

  def opponent
    game.players.select { |i| i.id != id }.first
  end

end
