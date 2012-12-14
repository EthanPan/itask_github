class CreateCourseYears < ActiveRecord::Migration
  def change
    create_table :course_years do |t|
      t.column :year,:string
      t.column :semester,:string
      t.column :course_id,:string
      t.timestamps
    end                    
    
  end
end
