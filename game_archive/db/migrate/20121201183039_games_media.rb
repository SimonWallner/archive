class GamesMedia < ActiveRecord::Migration
  def up
    create_table :games_media, :id => false do |t|
      t.references :game
      t.references :medium
    end
  end

  def down
    drop_table :games_media
  end
end