class AddStatusToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :status, :integer
  end
end
