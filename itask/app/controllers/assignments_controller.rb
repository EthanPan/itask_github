class AssignmentsController < ApplicationController
	before_filter :find_course_year_by_course_year_id, :only => [:new, :create,:index]
	
	def index
		#@courseyear = CourseYear.find(params[:course_year_id])
		@assignments = @course_year.assignments

	end
	
	def edit
	end
	
	def show_by_course
		@course_year = CourseYear.find(params[:id])
		@assignments = @course_year.assignments
	end 

	def show
	@assignment = Assignment.find(params[:id])
    
    @unfinish_students =  @assignment.unfinished_students

    respond_to do |format|
        format.html {
        @sca = StudentCourseAssignment.new 
        @sca.attachments.build
        # @sca.attachments.build
        }
    end
	    
	end

	def new
		@assignment = Assignment.new
			
	end

	def create
		 @assignment = Assignment.new(params[:assignment])
		 @assignment.status = 0
		 @assignment.course_year = @course_year
        
        if current_user
			@assignment.user = current_user
		end
		respond_to do |format|
      	if @assignment.save
      		add_event_info(@assignment,'create assignment',@assignment)
        	format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        	format.json { render json: @assignment, status: :created, location: @assignment }
      	else
        	format.html { render action: "new", notice: 'Imporper attributes' }
        	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      	end
    end
	end
end
