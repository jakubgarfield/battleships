class RenameCoordinatesInShips < ActiveRecord::Migration
  def change
    rename_column :ships, :nose_coordinate_x, :start_coordinate_x
    rename_column :ships, :nose_coordinate_y, :start_coordinate_y
    rename_column :ships, :tail_coordinate_x, :end_coordinate_x
    rename_column :ships, :tail_coordinate_y, :end_coordinate_y
  end
end
