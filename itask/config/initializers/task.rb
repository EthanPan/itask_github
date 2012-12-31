require 'rubygems'
require 'rufus/scheduler'

def add_event_info(assign,action,object)
 @event = Event.new
 @event.assignment = assign
 @event.operator = 0
 @event.action = action
 @event.object = object.id
 @event.save
end

scheduler = Rufus::Scheduler.start_new

scheduler.every("1m") do
   @assignment = Assignment.all
   @assignment.each { |assign|
    if ( assign.end_time <= Time.now.to_date ) and ( assign.status == 0 )
    	assign.status = 1
    	add_event_info(assign,'closed assignment.', assign)
    	assign.save
    end
   }

end