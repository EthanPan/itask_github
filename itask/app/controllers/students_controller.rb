class StudentsController < ApplicationController 
  def new
    @student = Student.new
  end
  def create
    @student = Student.new(params[:student]) 
    if @student.save
      flash[:success] = 'Register successfully!' 
    else
      flash[:alert] = 'Wrong!'
      render signup_path
    end
  end
  def show
  end
  def destroy
  end
end
