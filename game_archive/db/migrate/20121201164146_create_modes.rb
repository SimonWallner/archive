class CreateModes < ActiveRecord::Migration
  def change
    create_table :modes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
