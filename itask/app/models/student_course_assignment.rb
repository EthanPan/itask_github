class StudentCourseAssignment < ActiveRecord::Base
  attr_accessible :score, :comment,:finish_status
  belongs_to :assignment
  has_many :attachments
end
