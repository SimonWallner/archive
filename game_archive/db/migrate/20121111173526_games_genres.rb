class GamesGenres < ActiveRecord::Migration
  def up
    create_table :games_genres, :id => false do |t|
      t.references :game
      t.references :genre
    end
  end

  def down
    drop_table :games_genres
  end
end
