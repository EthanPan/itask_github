class AddColumnRoleToUserCourseYears < ActiveRecord::Migration
  def change
  	add_column :role ,:integer ,:deafult => 1
  end
end
