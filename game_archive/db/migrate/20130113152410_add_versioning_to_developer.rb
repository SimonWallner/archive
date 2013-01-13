class AddVersioningToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :version_id, :string
    add_column :developers, :version_number, :integer
    add_column :developers, :version_updated_at, :datetime
    add_column :developers, :version_author_id, :integer

    add_index :developers, :version_id
  end
end
