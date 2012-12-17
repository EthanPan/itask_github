class UserCourseYear < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :course_year
end
