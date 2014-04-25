class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :player_id, :null => false
      t.integer :nose_coordinate_x, :null => false
      t.integer :nose_coordinate_y, :null => false
      t.integer :tail_coordinate_x, :null => false
      t.integer :tail_coordinate_y, :null => false
  
      t.timestamps
    end
  end
end
