class Assignment < ActiveRecord::Base
  resourcify
  attr_accessible :title, :desp, :open_time, :end_time,:course_year_id,:user_id
  has_many :student_course_assignments         
  belongs_to :course_year
  belongs_to :user
end
