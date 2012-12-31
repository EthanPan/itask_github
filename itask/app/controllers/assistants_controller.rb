class AssistantsController < ApplicationController
	def destroy
		@assistant = Assistant.find(params[:id])
		@course_year = CourseYear.find(params[:course_year_id])
		if @assistant.destroy
			flash[:success] = "remove assistant successfully"
	    else
	    	flash[:alert] ="remove fail!"
		end
		redirect_to manage_course_year_path(@course_year)
	end
	def create
	    @course_year = CourseYear.find(params[:course_year_id])
	    @user = User.where(:user_num => params[:user_num]).first
	    if !@user.blank?
	       if @course_year.add_a_assistant(@user)
	        flash[:success] = "add #{@user.name} to be a assistant successfully"
	       else
	        flash[:alert] = "add fail! already add"
	      end
	    else
	      flash[:alert] ="add fail!user_num is wrong"

	    end
	    redirect_to manage_course_year_path(@course_year)
  end
end
