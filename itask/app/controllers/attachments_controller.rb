﻿class AttachmentsController < ApplicationController

require 'zip/zipfilesystem'
require 'rubygems'
require 'zip/zip'

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

	
	
	def show
		@attachment = Attachment.find(params[:id])
	    file_name = @attachment.user_upload_file_name
		file_url="#{Rails.root}/public/system/attachments/user_uploads/#{@attachment.id}/original/#{file_name}"
		destination = "#{Rails.root}/public/system/attachments/user_uploads/#{@attachment.id}/original"
		folder_name = destination + "/" + file_name[0...file_name.length-4]
		unzip_file(file_url,destination)#��ѹ�ļ�
		show_file(folder_name)#��ʾ�ļ�
		

	end
	
	

	private 
	def find_attachment
		@attachment = Attachment.find(params[:id])
		# Show 404 if the filename in the url is wrong
    	raise ActiveRecord::RecordNotFound if params[:filename] && params[:filename] != @attachment.user_upload_file_name
	end
	
	def unzip_file (file, destination)
		Zip::ZipFile.open(file) {|zip_file|
			zip_file.each {|f|
			f_path = File.join(destination, f.name)
			FileUtils.mkdir_p(File.dirname(f_path))
			zip_file.extract(f,f_path) unless File.exist?(f_path)
			}
		}
	end 
	
	def show_file(folder_url)
		Dir.foreach(folder_url){|file|
			
		}
	end
	


end
