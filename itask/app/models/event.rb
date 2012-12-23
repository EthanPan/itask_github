class Event < ActiveRecord::Base
  attr_accessible :action, :operator, :object
  belongs_to :assignment
end
