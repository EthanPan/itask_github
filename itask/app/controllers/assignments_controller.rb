class AssignmentsController < ApplicationController
	def index
		@assignments = Assignments.all
	end
	def show_by_course
		@courseyear = CourseYear.find(params[:id])
		@assignments = @courseyear.assignments
	end
end
