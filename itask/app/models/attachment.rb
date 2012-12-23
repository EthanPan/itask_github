class Attachment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :student_course_assignment
  has_attached_file :user_upload
end
