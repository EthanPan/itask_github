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
