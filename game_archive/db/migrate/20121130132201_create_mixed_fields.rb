class CreateMixedFields < ActiveRecord::Migration
  def change
    create_table :mixed_fields do |t|
      t.references :game
      t.references :developer
      t.references :company
      t.string :notFound
      t.string :additionalInfo
      t.references :type

      t.timestamps
    end
    add_index :mixed_fields, :game_id
    add_index :mixed_fields, :developer_id
    add_index :mixed_fields, :company_id
    add_index :mixed_fields, :type_id
  end
end
