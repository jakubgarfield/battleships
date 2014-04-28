class Ship < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :nose_coordinate_x, :nose_coordinate_y, :tail_coordinate_x, :tail_coordinate_y, :presence => true
  validates :nose_coordinate_x, :nose_coordinate_y, :tail_coordinate_x, :tail_coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 10 }

end
