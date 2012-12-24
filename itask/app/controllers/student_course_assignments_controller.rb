class StudentCourseAssignmentsController < ApplicationController
	
    def index
    	@sca = StudentCourseAssignment.all
    end
	def new
		@sca = StudentCourseAssignment.new
		@sca.attachments.build

	end
	def create
		@assignment = Assignment.find(params[:assignment_id])
		if @assignment.student_course_assignments.find(:all,:include => [:user], :conditions =>["user_id = ?", current_user.id])
			flash[:alert] = "you have uploaded"			
			redirect_to course_years_path
			return
	    end
		@sca = StudentCourseAssignment.new(params[:student_course_assignment])
		
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
