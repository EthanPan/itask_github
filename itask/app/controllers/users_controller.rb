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
    	@all_finished_assignments = @user.all_finished_assignments.paginate(:page => params[:page])

    	@all_unfinished_assignments = @user.all_unfinished_assignments.paginate(:page => params[:page],:per_page=>10)
    end
    def courses
    	@user = User.find(params[:id])
    	@all_course_years = @user.all_course_years.paginate(:page => params[:page])
    end

end
