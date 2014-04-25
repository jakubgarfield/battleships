class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :player_id, :null => false
      t.integer :coordinate_x, :null => false
      t.integer :coordinate_y, :null => false
      t.boolean :correct, :null => false

      t.timestamps
    end
  end
end
