class CreateReleaseDates < ActiveRecord::Migration
  def change
    create_table :release_dates do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :additional_info
      t.references :game

      t.timestamps
    end
    add_index :release_dates, :game_id
  end
end
