class Assignment < ActiveRecord::Base
  resourcify
  attr_accessible :title, :desp, :end_time,:course_year_id,:user_id
  has_many :student_course_assignments
  has_many :events         
  belongs_to :course_year
  belongs_to :user

  validates :end_time, :format => { :with => /\A(1|2)\d{3}-(0|1)\d-\d{2}\z/, :message => "format should like 2012-01-01"}
end
