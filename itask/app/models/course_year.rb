class CourseYear < ActiveRecord::Base
  # attr_accessible :title, :body 
  belongs_to :course
  has_many   :assignments
  has_many   :stu_course_years
  has_many   :students, :through => :stu_course_years
end
