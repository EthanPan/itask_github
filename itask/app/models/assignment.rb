class Assignment < ActiveRecord::Base
  attr_accessible :title, :desp, :open_time, :end_time,:course_year_id,:user_id         
  belongs_to :course_year
  belongs_to :user
end
