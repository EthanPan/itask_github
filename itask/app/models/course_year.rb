class CourseYear < ActiveRecord::Base
	resourcify
  attr_accessible :year, :semester, :course_id, :notice 
  belongs_to :course
  has_many   :assignments ,:dependent => :destroy
  has_many   :user_course_years
  has_many   :users, :through => :user_course_years
  has_many   :assistants
  validates :year , :format => { :with =>/[1-9]\d{3}-[1-9]\d{3}$/,:message =>"format should like 2012-2013" }
  validates :semester, :inclusion => { :in => %w(1 2),:message => "%{value} is not a valid semester" }

  def active_students
  	user_course_years = UserCourseYear.where(:course_year_id => self.id,:status => 1)
  	students = Array.new
  	user_course_years.each do |ucy|
  		students.push(ucy.user)
  	end
  	students
  end
  def add_a_assistant(user)
  	
  	if Assistant.where(:user_id => user.id).first
  		return false
  	else
  		assistant = Assistant.new
  	    assistant.course_year = self
  		assistant.user = user
  		user.add_role :TA
  		assistant.save
  	end

  end
  def has_a_student(student_id)
  	!UserCourseYear.where(:user_id => student_id,:course_year_id => self.id).blank?
  end
end
