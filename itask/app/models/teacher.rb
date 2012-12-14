class Teacher < ActiveRecord::Base
  attr_accessible :teacher_id, :name, :sex 
  has_many :courses
end
