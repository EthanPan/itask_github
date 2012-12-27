class RenameColumnUserNumInUserCourseYears < ActiveRecord::Migration
  def change
  	rename_column :user_course_years, :user_num, :user_id
  end
end
