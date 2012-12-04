class GamesModes < ActiveRecord::Migration
  def up
    create_table :games_modes, :id => false do |t|
      t.references :game
      t.references :mode
    end
  end

  def down
    drop_table :games_modes
  end
end
