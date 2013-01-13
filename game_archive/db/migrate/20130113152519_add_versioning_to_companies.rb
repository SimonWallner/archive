class AddVersioningToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :version_id, :string
    add_column :companies, :version_number, :integer
    add_column :companies, :version_updated_at, :datetime
    add_column :companies, :version_author_id, :integer

    add_index :companies, :version_id
  end
end
