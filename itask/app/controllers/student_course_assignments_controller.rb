class StudentCourseAssignmentsController < ApplicationController
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

	
	def grade
	if request.put?
	     @sca = StudentCourseAssignment.update(params[:id],:score=>params[:student_course_assignment][:score],:comment=>params[:student_course_assignment][:comment])
		 
		 @assignment = Assignment.find(params[:assignment_id])
		 if @sca.save
			flash[:alert] = "successfully"
			redirect_to assignment_path(@assignment)
		 else
		     flash[:alert] = "fail!"
			 redirect_to course_years_path
		 end

	   
		
	else
		 @sca = StudentCourseAssignment.find(params[:id])
		 @assignment = Assignment.find(params[:assignment_id])
		 end
	end
		
end
