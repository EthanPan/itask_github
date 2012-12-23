class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  # before_filter :find_current_user
  # before_filter :authenticate_user!
  def is_manager
  end

  # def logout_user
  # 	session[:user_num] = nil
  # end
  # def find_current_user
  # 	@current_user = nil
  # 	if session[:user_num]
  # 		@current_user = (User.find_by_user_num(session[:user_num]) rescue nil)
  #   end
  #   @current_user
  # end
  def add_event_info(assign,action,object)
    @event = Event.new
    @event.assignment = assign
    @event.operator = current_user.id
    @event.action = action
    @event.object = object.id
    @event.save
  end
  def find_course_year_by_course_year_id
    @courseyear = CourseYear.find(params[:course_year_id])
  rescue ActiveRecord::RecordNotFound
    render 404
  end


end
