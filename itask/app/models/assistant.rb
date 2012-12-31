class Assistant < ActiveRecord::Base
  attr_accessible :desp ,:user_id,:course_year_id
  belongs_to :course_year
  belongs_to :user
  
 
  
end
