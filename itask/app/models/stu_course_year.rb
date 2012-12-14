class StuCourseYear < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :student
  belongs_to :course_year
end
