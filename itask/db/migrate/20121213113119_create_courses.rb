class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.column :course_num,:string  
      t.column :user_id,:string
      t.column :name,:string

      t.timestamps
    end            
    add_index :courses, :course_num, :unique => true
    
  end
end
