class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :embedcode
      t.references :game

      t.timestamps
    end
    add_index :videos, :game_id
  end
end
