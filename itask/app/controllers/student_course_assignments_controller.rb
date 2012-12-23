class StudentCourseAssignmentsController < ApplicationController
	
    def index
    	@sca = StudentCourseAssignment.all
    end
	def new
		@sca = StudentCourseAssignment.new
	end
	def create
		@sca = StudentCourseAssignment.new(params[:student_assignment])
		@assignment = Assignment.find(params[:assignment_id])
		@sca.user = current_user
		@sca.assignment = @assignment
		if @sca.save
			flash[:alert] = "success"
			redirect_to course_years_path
		else
			flash[:alert] = "fail"
			redirect_to course_years_path
		end

	end
end
