class Guess < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :player_id, :coordinate_x, :coordinate_y, :presence => true
  validates :coordinate_x, :coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 10 }

end
