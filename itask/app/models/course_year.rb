class CourseYear < ActiveRecord::Base
	resourcify
  attr_accessible :year, :semester, :course_id 
  belongs_to :course
  has_many   :assignments
  has_many   :user_course_years
  has_many   :users, :through => :user_course_years
  
  validates :year , :format => { :with =>/[1-9]\d{3}-[1-9]\d{3}$/,:message =>"format should like 2012-2013" }
  validates :semester, :inclusion => { :in => %w(1 2),:message => "%{value} is not a valid semester" }
end
