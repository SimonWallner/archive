class CreateMixedFields < ActiveRecord::Migration
  def change
    create_table :mixed_fields do |t|
      t.references :game
      t.references :developer
      t.references :company
      t.string :not_found
      t.string :additional_info
      t.references :mixed_field_type

      t.timestamps
    end
    add_index :mixed_fields, :game_id
    add_index :mixed_fields, :developer_id
    add_index :mixed_fields, :company_id
    add_index :mixed_fields, :mixed_field_type_id
  end
end
