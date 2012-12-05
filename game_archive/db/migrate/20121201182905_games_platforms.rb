class GamesPlatforms < ActiveRecord::Migration
  def up
    create_table :games_platforms, :id => false do |t|
      t.references :game
      t.references :platform
    end
  end

  def down
    drop_table :games_platforms
  end
end

