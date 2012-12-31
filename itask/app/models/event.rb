class Event < ActiveRecord::Base
  attr_accessible :action, :operator, :object, :assignment_id
  belongs_to :assignment
end
