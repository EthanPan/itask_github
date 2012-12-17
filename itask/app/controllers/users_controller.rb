class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
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

end
