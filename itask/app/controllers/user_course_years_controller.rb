class UserCourseYearsController < ApplicationController
	def create

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
