class StudentCourseAssignment < ActiveRecord::Base
  attr_accessible :score, :comment,:finish_status
  belongs_to :assignment
  belongs_to :user
  has_many :attachments
end
