class AddPopularityToGame < ActiveRecord::Migration
  def change
	add_column :games, :popularity, :integer
  end
end
