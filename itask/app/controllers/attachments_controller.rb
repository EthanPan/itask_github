class AttachmentsController < ApplicationController
    before_filter :find_attachment ,:except=> :upload
	load_and_authorize_resource
	require 'zip/zip'
	require 'zip/zipfilesystem'
		
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
		file_type_bool = file_name[-4..-1]
		if file_type_bool == ".zip"
		
			file_url="#{Rails.root}/public/system/attachments/user_uploads/#{@attachment.id}/original/#{file_name}"
			destination = "#{Rails.root}/public/system/attachments/user_uploads/#{@attachment.id}/original"
			
			folder_name = destination + "/" + file_name[0...file_name.length-4]
			unzip_file(file_url,destination)#解压文件
		
			@zip_file_name = Array.new
			@zip_file_type = Array.new
			@zip_file_degree = Array.new
			@zip_file_url = Array.new
		
			#显示文件
			url_root="/system/attachments/user_uploads/#{@attachment.id}/original"+ "/" + file_name[0...file_name.length-4]
			degree=0
			show_file(folder_name,url_root,degree)
		else
			redirect_to @attachment.user_upload.url(:original,false)
		end

	end
	
	def file
		
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
	
	def show_file(current_folder,current_url,i)
	
		last_degree = i
		
		stored_url=current_url
		Dir.foreach(current_folder) do |f|
			next if f == '.' or f == '..'
				
				i = i+1
				
				
				if f.include?"."
					@zip_file_name.push(f)
					@zip_file_type.push("file")
					current_url=stored_url+"/"+f
					@zip_file_url.push(current_url)
					@zip_file_degree.push(last_degree)
					
				else
					@zip_file_name.push(f)
					@zip_file_type.push("folder")
					
					current_folder=current_folder+"/"+f
					current_url=stored_url+"/"+f
					@zip_file_url.push(current_url)
					@zip_file_degree.push(last_degree)
					show_file(current_folder,current_url,i)
				end
				
					
				
		end
	end
	
	


end
