class AddCloumnStatusToUserCourseYear < ActiveRecord::Migration
  def change
  	add_column :user_course_years, :status, :integer
  	add_column :user_course_years, :score,  :integer
  end
end
