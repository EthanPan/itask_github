class CourseYear < ActiveRecord::Base
  attr_accessible :year, :semester, :course_id 
  belongs_to :course
  has_many   :assignments
  has_many   :stu_course_years
  has_many   :students, :through => :stu_course_years
end
