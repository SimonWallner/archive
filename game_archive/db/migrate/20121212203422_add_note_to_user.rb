class AddNoteToUser < ActiveRecord::Migration
  def change
	add_column :users, :note, :string		# e.g. reason for being blocked
  end
end
