class AttachmentsController < ApplicationController
    before_filter :find_attachment ,:except=> :upload
	def download
	   @attachment = Attachment.find(params[:id])
	    file_name = @attachment.user_upload_file_name
	    if !file_name.nil?
			# send_file "#{Rails.root}/public/system/documents/#{@attachment.id}/original/#{file_path}", :x_sendfile => true 
			send_file "#{Rails.root}/public/system/attachments/user_uploads/#{@attachment.id}/original/#{file_name}" ,:x_sendfile => true
	        # render :nothing => true
	        return
	    end
	end

	private 
	def find_attachment
		@attachment = Attachment.find(params[:id])
		# Show 404 if the filename in the url is wrong
    	raise ActiveRecord::RecordNotFound if params[:filename] && params[:filename] != @attachment.user_upload_file_name
	end

end
