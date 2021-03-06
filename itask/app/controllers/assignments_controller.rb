class AssignmentsController < ApplicationController
	before_filter :find_course_year_by_course_year_id
	before_filter :find_assignment_by_id,:only => [:show,:edit,:update,:unfinished]
	before_filter :initialize_breadcrumb ,:except => [:index,:new,:create]
	load_and_authorize_resource
	skip_authorize_resource :only => [:new,:create]

	def index
		#@courseyear = CourseYear.find(params[:course_year_id])
		@assignments = @course_year.assignments
		drop_breadcrumb("Courses", course_years_path)
    	drop_breadcrumb(@course_year.course.name)
	end
	
	def edit
	end

	def update
		@assignment = Assignment.find(params[:id])
		respond_to do |format|

      	if @assignment.update_attributes(params[:assignment])
          if @assignment.end_time > Time.now.to_date
            @assignment.status = 0
            @assignment.save
          end
        	format.html { redirect_to course_year_assignment_path(@assignment.course_year,@assignment), notice: 'Assignemnt was successfully updated.' }
        	format.json { head :no_content }
      	else
        	format.html { render action: "edit" }
        	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      	end
    	end
	end
	
	def show_by_course
		@assignments = @course_year.assignments.paginate(:page => params[:page],:per_page=>10)
	end 
    def unfinished
    	@unfinish_students =  @assignment.unfinished_students.paginate(:page => params[:page],:per_page=>10)
    	 respond_to do |format|
        format.html {
        @sca = StudentCourseAssignment.new 
        @sca.attachments.build
        # @sca.attachments.build
        }
    end
    end
	def show
	
    
        @finish_student_course_assignments = @assignment.student_course_assignments.paginate(:page => params[:page],:per_page=>10)
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
		drop_breadcrumb("Courses", course_years_path)
    	drop_breadcrumb(@course_year.course.name,course_year_path(@course_year))
    	drop_breadcrumb("New Assignment")
			
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
        	format.html { redirect_to course_year_assignment_path(@course_year,@assignment), notice: 'Assignment was successfully created.' }
        	format.json { render json: @assignment, status: :created, location: @assignment }
      	else
        	format.html { render action: "new", notice: 'Imporper attributes' }
        	format.json { render json: @assignment.errors, status: :unprocessable_entity }
      	end
    end

	end
	def find_assignment_by_id
		@assignment = Assignment.find(params[:id])

	end
  	def initialize_breadcrumb
     	drop_breadcrumb("Courses", course_years_path)
    	drop_breadcrumb(@course_year.course.name,course_year_path(@course_year))
        drop_breadcrumb(@assignment.title)
  	end
end
