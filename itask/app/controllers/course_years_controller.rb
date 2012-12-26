class CourseYearsController < ApplicationController
  def index
    @courseyears = CourseYear.all    
  end
  def edit
  	@courseyear = CourseYear.find(params[:id])
  end
  def show
    @courseyear = CourseYear.find(params[:id])

  end
  def update
  	@courseyear = CourseYear.find(params[:id])

    respond_to do |format|
      if @courseyear.update_attributes(params[:course_year])
        format.html { redirect_to course_year_assignments_path(@courseyear), notice: 'Notice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @courseyear.errors, status: :unprocessable_entity }
      end
    end
  end
end
