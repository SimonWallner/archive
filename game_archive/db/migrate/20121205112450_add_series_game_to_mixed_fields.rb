class AddSeriesGameToMixedFields < ActiveRecord::Migration
  def change
    add_column :mixed_fields, :series_game_id, :integer
    add_index :mixed_fields, :series_game_id
  end
end
