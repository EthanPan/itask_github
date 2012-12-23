class AddAttachmentInfoToAttachments < ActiveRecord::Migration
  def change
  	add_column :attachments, :user_id, :integer
  	add_column :attachments, :student_course_assignment_id ,:integer
  end
end
