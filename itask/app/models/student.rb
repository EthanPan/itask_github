class Student < ActiveRecord::Base
  attr_accessible :stu_id, :name, :sex 
  has_many   :stu_course_years
  has_many   :course_years, :through => :stu_course_years
end