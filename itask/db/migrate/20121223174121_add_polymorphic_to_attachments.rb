class AddPolymorphicToAttachments < ActiveRecord::Migration
  def change
  	# 关联对象的id
    add_column :attachments, :attachmentable_id, :integer, :null => false, :default => 0
    # 关联对象的类名，如:StudentCourseAssignment
    add_column :attachments, :attachmentable_type, :string, :null => false, :default => ''
  end
end
