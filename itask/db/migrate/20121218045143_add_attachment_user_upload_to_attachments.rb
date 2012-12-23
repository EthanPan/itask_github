class AddAttachmentUserUploadToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.has_attached_file :user_upload
    end
  end

  def self.down
    drop_attached_file :attachments, :user_upload
  end
end
