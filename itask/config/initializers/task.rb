require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.every("2m") do
   @assignment = Assignment.all
   @assignment.each { |assign| 
   	if assign.end_time <= Time.now.to_date
   		assign.status = 1
   		assign.save
   	end
   }

end