class AddPopularityToDeveloper < ActiveRecord::Migration
  def change
	add_column :developers, :popularity, :integer
  end
end
