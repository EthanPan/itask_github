class ApplicationController < ActionController::Base
  
  protect_from_forgery

  require 'will_paginate/array'
  # before_filter :find_current_user
  # before_filter :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
    ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
    ## this render call should be:
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end
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
    if current_user != nil 
      @event.operator = current_user.id
    end
    @event.action = action
    @event.object = object.id
    @event.save
  end
  def find_course_year_by_course_year_id
    @course_year = CourseYear.find(params[:course_year_id])
  rescue ActiveRecord::RecordNotFound
    render 404
  end
  
  def file_or_folder
  end


end
