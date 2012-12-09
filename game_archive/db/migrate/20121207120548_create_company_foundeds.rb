class CreateCompanyFoundeds < ActiveRecord::Migration
  def change
    create_table :company_foundeds do |t|
      t.references :company
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps
    end
    add_index :company_foundeds, :company_id
  end
end
