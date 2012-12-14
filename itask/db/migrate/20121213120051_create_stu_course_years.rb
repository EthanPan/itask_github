class CreateStuCourseYears < ActiveRecord::Migration
  def change
    create_table :stu_course_years do |t|
      t.column :stu_id,:integer
      t.column :course_year_id,:integer
      t.timestamps
    end
  end
end
