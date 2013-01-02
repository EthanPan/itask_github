class CourseYearsController < ApplicationController
  before_filter :find_course_year_by_id ,:except => :index
  before_filter :initialize_breadcrumb ,:except => :index
  load_and_authorize_resource


  def index
    @course_years = CourseYear.all    
  end
  def edit

  end
  def show
    
  end
  def manage
    @course_year = CourseYear.find(params[:id])
    @user_course_years = @course_year.user_course_years.paginate(:page => params[:page],:per_page=>10)
    @assistants =  @course_year.assistants.paginate(:page => params[:page],:per_page=>10)
  end


  def apply

    current_user.apply_for_course(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def remove_student

    current_user.remove_from_course_year(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def approve_application

    current_user.attend_to_course(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def update
  	@course_year = CourseYear.find(params[:id])

    respond_to do |format|

      if @course_year.update_attributes(params[:course_year])
        format.html { redirect_to course_year_path(@course_year), notice: 'Notice was successfully updated.' }

        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_year.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def find_course_year_by_id
    @course_year = CourseYear.find(params[:id])
  end
  
  def initialize_breadcrumb

    drop_breadcrumb("Courses", course_years_path)
    drop_breadcrumb(@course_year.course.name)

  end
end
