class Assignment < ActiveRecord::Base
  attr_accessible :title, :desp, :open_time, :end_time         
  belongs_to :course_year
end
