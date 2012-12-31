class Assignment < ActiveRecord::Base
  resourcify
  attr_accessible :title, :desp, :end_time,:course_year_id,:user_id
  has_many :student_course_assignments
  has_many :events         
  belongs_to :course_year
  belongs_to :user
  
  #validates :end_time, :format => { :with => /\A(0|1)\d\/\d{2}\/(1|2)\d{3}\z/, :message => "format should like 01-01-2012"}
  
 
  def unfinished_students

  	student_course_assignments = self.student_course_assignments
    finish_students = Array.new

	    student_course_assignments.each do |sca|
	         finish_students.push(sca.user)
	    end

    students = self.course_year.active_students
    students - finish_students
  end

  def finished_students
        student_course_assignments = self.student_course_assignments
        finish_students = Array.new

	    student_course_assignments.each do |sca|
	         finish_students.push(sca.user)
	    end
	    finish_students
  end
  def has_a_finished_student(user)
        student_course_assignments = self.student_course_assignments
        finish_students = Array.new

	    student_course_assignments.each do |sca|
	         finish_students.push(sca.user)
	    end
	    finish_students.include? user
  end
end
