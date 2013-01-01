class Assistant < ActiveRecord::Base
  attr_accessible :desp ,:user_id,:course_year_id
  belongs_to :course_year
  belongs_to :user
  
 def remove_a
 	if Assistant.where(:user_id => self.user_id).count == 1
 		self.user.remove_role :TA
 		self.destroy
    else
        self.destroy	
 	end
 end
  
end
