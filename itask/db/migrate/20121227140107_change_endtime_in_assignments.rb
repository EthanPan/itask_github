class ChangeEndtimeInAssignments < ActiveRecord::Migration
  def change
  	change_column :assignments, :end_time, :date
  end
end
