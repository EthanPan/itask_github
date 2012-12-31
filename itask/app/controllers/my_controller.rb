class MyController < ApplicationController
	def assignments_finished
		@all_finished_assignments = current_user.all_finished_assignments.paginate(:page => 1)
	end
	def assignments_unfinished
		@all_unfinished_assignments = current_user.all_unfinished_assignments.paginate(:page => params[:page],:per_page=>10)
	end
end
