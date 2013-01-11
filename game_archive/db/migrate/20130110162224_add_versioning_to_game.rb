class AddVersioningToGame < ActiveRecord::Migration
  def change
    add_column :games, :version_id, :string
    add_column :games, :version_number, :integer
    add_column :games, :version_updated_at, :datetime
    add_column :games, :version_author_id, :integer

    add_index :games, :version_id
  end
end
