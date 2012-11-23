class AddImageToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :image, :string
  end
end
