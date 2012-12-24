class StudentCourseAssignment < ActiveRecord::Base
  attr_accessible :score, :comment, :finish_status,:attachments, :attachments_attributes
  has_many :attachments ,:as => :attachmentable,:dependent => :destroy
  belongs_to :assignment
  belongs_to :user
  accepts_nested_attributes_for :attachments
end
