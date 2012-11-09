class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :titel
      t.text :content

      t.timestamps
    end
  end
end
