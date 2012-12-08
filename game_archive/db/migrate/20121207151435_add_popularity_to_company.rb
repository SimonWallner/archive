class AddPopularityToCompany < ActiveRecord::Migration
  def change
	add_column :companies, :popularity, :integer
  end
end
