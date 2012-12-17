class AssignmentsController < ApplicationController
	before_filter :find_course_year_by_course_year_id, :only => [:new, :create,:index]
	
	def index
		#@courseyear = CourseYear.find(params[:course_year_id])
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
		 @assignment.course_year = @courseyear
        user = User.find_by_user_num(session[:user_num])
        if user
			@assignment.user = user
		end
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
