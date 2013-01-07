class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.text :content
      t.references :game
      t.references :company
      t.references :developer

      t.timestamps
    end
    add_index :fields, :game_id
    add_index :fields, :company_id
    add_index :fields, :developer_id
  end
end
