class CreateUserCourseYears < ActiveRecord::Migration
  def change
    create_table :user_course_years do |t|
      t.column :user_num,:integer
      t.column :course_year_id,:integer
      t.timestamps
    end
  end
end
