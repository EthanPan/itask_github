class CourseYearsController < ApplicationController
  def index
    @course_years = CourseYear.all    
  end
end
