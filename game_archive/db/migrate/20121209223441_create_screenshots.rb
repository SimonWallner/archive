class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :image
      t.references :game

      t.timestamps
    end
    add_index :screenshots, :game_id
  end
end
