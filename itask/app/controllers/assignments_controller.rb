class AssignmentsController < ApplicationController
	def index
		@assignments = Assignment.all
	end
	def show_by_course
		@courseyear = CourseYear.find(params[:id])
		@assignments = @courseyear.assignments
	end 
	def show
	  @assignment = Assignment.find(params[:id])
	end
end
