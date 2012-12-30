class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end
	def show
		@user = User.find(params[:id])
		


	end
	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = 'Register successfully!' 
        else
      		flash[:alert] = 'Wrong!'
      	render signup_path
        end
    end
    def assignments
    	@user = User.find(params[:id])
    	@all_finished_assignments = @user.all_finished_assignments
    end
    def courses
    	@user = User.find(params[:id])
    	@all_user_course_year = @user.all_user_course_years
    end

end
