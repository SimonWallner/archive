class AddVersioningToGame < ActiveRecord::Migration
  def change
    add_column :games, :object_id, :integer
    add_column :games, :version_number, :integer
    add_column :games, :updated_ts, :datetime
    add_column :games, :author_id, :integer

    add_index :games, :object_id
  end
end
