class CreateMixedFieldTypes < ActiveRecord::Migration
  def change
    create_table :mixed_field_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
