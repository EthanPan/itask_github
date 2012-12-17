class AddColumnUserIdToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :user_id, :integer
  end
end
