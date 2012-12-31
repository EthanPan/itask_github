class AddAssignmentIdToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :assignment_id, :integer
  end
end
