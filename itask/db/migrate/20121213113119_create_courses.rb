class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.column :course_id,:string  
      t.column :teach_id,:string
      t.column :name,:string

      t.timestamps
    end            
    add_index :courses, :course_id, :unique => true
    
  end
end
