class AddCoordToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :longitude, :float
    add_column :zombies, :latitude, :float
  end
end
