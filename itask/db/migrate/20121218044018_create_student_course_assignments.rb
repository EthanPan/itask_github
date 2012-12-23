class CreateStudentCourseAssignments < ActiveRecord::Migration
  def change
    create_table :student_course_assignments do |t|
      t.column :assignment_id ,:integer
      t.column :user_id,:integer
      t.column :score ,:integer
      t.column :comment ,:string
      t.column :finish_status ,:integer #0为未完成 1为完成
      t.timestamps
    end
  end
end
