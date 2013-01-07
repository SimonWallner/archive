class GamesTags < ActiveRecord::Migration
  def up
    create_table :games_tags, :id => false do |t|
      t.references :game
      t.references :tag
    end
  end

  def down
    drop_table :games_tags
  end
end