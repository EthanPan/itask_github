class Course < ActiveRecord::Base
  attr_accessible :course_id, :teacher_id, :name 
  belongs_to :teacher 
  has_many   :course_years
end
