class CourseYearsController < ApplicationController
  def index
    @course_years = CourseYear.where( :year => '20122013', :semester => '1')    
  end
end
