class Assignment < ActiveRecord::Base
  resourcify
  attr_accessible :title, :desp, :end_time,:course_year_id,:user_id, :status
  has_many :student_course_assignments 
  has_many :events ,:dependent => :destroy
  belongs_to :course_year
  belongs_to :user
  
  validates_presence_of :title, :desp, :end_time
  validates :end_time, :format => { :with => /\A(1|2)\d{3}-(0|1)\d-\d{2}\z/, :message => "format should like 2012-01-01"}

  def unfinished_students

  	all_students = User.joins(:user_course_years => :course_year).where(:course_years =>{ :id => self.course_year_id},:user_course_years => {:status => 1})    
    
  	# student_course_assignments = self.student_course_assignments
    # finish_students = Array.new

	  #   student_course_assignments.each do |sca|
	  #        finish_students.push(sca.user)
	  #   end

   #  students = self.course_year.active_students
   #  students - finish_students
  end

  def finished_students
      User.joins(:student_course_assignments => :assignments).where(:assignments => {:id => self.id})     
     #    Assignment.joins(:student_course_assignments => :user).where(:student_course_assignments => {:user_id => self.id})    

     #    student_course_assignments = self.student_course_assignments
     #    finish_students = Array.new

	    # student_course_assignments.each do |sca|
	    #      finish_students.push(sca.user)
	    # end
	    # finish_students
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
