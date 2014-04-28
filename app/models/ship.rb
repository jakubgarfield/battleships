class Ship < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :presence => true
  validates :start_coordinate_x, :start_coordinate_y, :end_coordinate_x, :end_coordinate_y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 10 }

  def sunk?
    false  
  end

  def hit?(x, y)
    false
  end

end
