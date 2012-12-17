class Course < ActiveRecord::Base
  attr_accessible :course_num, :user_id, :name 
  belongs_to :user 
  has_many   :course_years
end
