class Course < ActiveRecord::Base
  # attr_accessible :title, :body 
  belongs_to :teacher 
  has_many   :course_years
end
