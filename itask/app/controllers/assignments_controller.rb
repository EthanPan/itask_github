class AssignmentsController < ApplicationController
	def index
		@courseyear = CourseYear.find(params[:course_year_id])
		@assignments = @courseyear.assignments
	end
	def show_by_course
		@courseyear = CourseYear.find(params[:id])
		@assignments = @courseyear.assignments
	end 

	def show
	    @assignment = Assignment.find(params[:id])
	end

	def new
		@assignment = Assignment.new		
	end

	def create
		@assignment = Assignment.new(params[:assignment])
		@courseyear = CourseYear.find(params[:course_year_id])
		@assignment.course_year = @courseyear
		respond_to do |format|
      	if @assignment.save
        	format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        	format.json { render json: @assignment, status: :created, location: @assignment }
      	else
        	format.html { render action: "new" }
        	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      	end
    end
	end
end
