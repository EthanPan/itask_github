class UserCourseYearsController < ApplicationController
	load_and_authorize_resource
	def create
      @user = User.where(:user_num => params[:user_num]).first
      @course_year = CourseYear.find(params[:course_year_id])
      if !@user.blank?
      	@user_course_year = UserCourseYear.new(:user=>@user,:course_year => @course_year,:status=>1)
        if @user_course_year.save
         flash[:success] ="success!"
      	end
      else
      	flash[:alert] = "fail!"
      end
      redirect_to manage_course_year_path(@course_year)
	end

	def edit

	end

	def approve
		@uc = UserCourseYear.find(params[:id])
		@uc.user.attend_to_course(@uc.course_year.id)
		@course_year = @uc.course_year
		redirect_to manage_course_year_path(@course_year)
	end
	def destroy
		@uc = UserCourseYear.find(params[:id])
		@uc.destroy
		@course_year = @uc.course_year
		redirect_to manage_course_year_path(@course_year)
	end
end
