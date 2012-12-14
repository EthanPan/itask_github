class Assignment < ActiveRecord::Base
  # attr_accessible :title, :body         
  belongs_to :course_year
end
