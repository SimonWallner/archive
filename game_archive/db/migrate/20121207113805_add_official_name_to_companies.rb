class AddOfficialNameToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :official_name, :string
  end
end
