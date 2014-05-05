class RemoveActiveFromPlayer < ActiveRecord::Migration
  def change
    remove_column :players, :active, :boolean
  end
end
