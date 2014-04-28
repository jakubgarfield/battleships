class RemoveCorrectFromGuesses < ActiveRecord::Migration
  def change
    remove_column :guesses, :correct, :boolean
  end
end
