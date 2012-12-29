class CourseYearsController < ApplicationController
  def index
    @course_years = CourseYear.all    
  end
  def edit
  	@course_year = CourseYear.find(params[:id])
  end
  def show
    @course_year = CourseYear.find(params[:id])

  end
  def manage
    @course_year = CourseYear.find(params[:id])
  end
  def apply
    @course_year = CourseYear.find(params[:id])
    current_user.apply_for_course(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def remove_student
    @course_year = CourseYear.find(params[:id])
    current_user.remove_from_course_year(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def approve_application
    @course_year = CourseYear.find(params[:id])
    current_user.attend_to_course(params[:id])
    redirect_to course_year_path(@course_year)
  end
  def update
  	@course_year = CourseYear.find(params[:id])

    respond_to do |format|
      if @course_year.update_attributes(params[:course_year])
        format.html { redirect_to course_year_assignments_path(@course_year), notice: 'Notice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_year.errors, status: :unprocessable_entity }
      end
    end
  end
end
