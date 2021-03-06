class Attachment < ActiveRecord::Base
  attr_accessible :user_upload
  belongs_to :attachmentable , :polymorphic => true
  has_attached_file :user_upload,:url => "/system/attachments/:attachment/:id/:style/:basename.:extension"
end
