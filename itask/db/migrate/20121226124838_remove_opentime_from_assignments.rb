class RemoveOpentimeFromAssignments < ActiveRecord::Migration
  def change
  	remove_column :assignments, :open_time
  end
end
