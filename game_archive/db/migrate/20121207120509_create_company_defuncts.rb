class CreateCompanyDefuncts < ActiveRecord::Migration
  def change
    create_table :company_defuncts do |t|
      t.references :company
      t.integer :day
      t.integer :month
      t.integer :year
      t.string :additional_info

      t.timestamps
    end
    add_index :company_defuncts, :company_id
  end
end
