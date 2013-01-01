class UserCourseYear < ActiveRecord::Base
  attr_accessible :status ,:score ,:user,:course_year
  belongs_to :user
  belongs_to :course_year
  scope :approve ,where(:status => 1)
end
