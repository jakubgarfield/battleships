class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_id, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end
end
