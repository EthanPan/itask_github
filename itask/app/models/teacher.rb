class Teacher < ActiveRecord::Base
  attr_accessible :teach_id, :name, :sex 
  has_many :courses
end
