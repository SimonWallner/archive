class CreateReportblockcontents < ActiveRecord::Migration
  def change
    create_table :reportblockcontents do |t|
      t.integer :content_type
      t.integer :content_id
      t.integer :status
      t.string :reason
      t.string :email
      t.integer :admin_id

      t.timestamps
    end
  end
end
