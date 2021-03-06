class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids
  attr_accessible :email, :password, :password_confirmation, :remember_me
  include Gravtastic
  gravtastic
 
  attr_accessible :user_num, :name, :sex, :id
  has_many   :user_course_years
  has_many   :courses
  has_many   :assignments
  has_many   :assistants
  has_many   :student_course_assignments
  has_many   :course_years, :through => :user_course_years
  validates_presence_of :user_num,:email
  validates_uniqueness_of :user_num,:email
  after_create :deafult_role
  def deafult_role
    self.add_role :student
  end

  def self.try_to_login(user_num,password)
  	return nil if password.empty?
    user = find_by_user_num_and_password(user_num,password)
    if user
    	return user
    else
       return nil
     end	
  end

  def self.current=(user)
    @current_user = user
  end

  def self.current
    @current_user ||= User.anonymous
  end

  def has_a_course_year(course_year_id)
    UserCourseYear.where(:course_year_id =>course_year_id,:user_id => self.id,:status => 1).first
  end
  def attend_to_course(course_year_id)
    if @student_course_year = UserCourseYear.where(:course_year_id =>course_year_id,:user_id => self.id).first
      @student_course_year.status = 1
      @student_course_year.save
    end
  end
  
  def all_finished_assignments
     Assignment.joins(:student_course_assignments => :user).where(:student_course_assignments => {:user_id => self.id})    
  end

  def all_unfinished_assignments
      all_assignments = Assignment.joins(:course_year => :users).where(:users => {:id => self.id})
       finished_assignments = all_finished_assignments
       
       if !finished_assignments.blank?
           all_assignments - finished_assignments
       else
           all_assignments
       end
  end
  def all_course_years
      CourseYear.joins(:user_course_years => :user).where(:users => {:id => self.id})
  end
  
 
  def apply_for_course(course_year_id)
    if !course_year_id.blank?
      @course_year = CourseYear.find(course_year_id)
      if @course_year.has_a_student(self.id)
        return
      end
      @student_course_year = @course_year.user_course_years.build(:status => 0)
      @student_course_year.user = self
      self.add_role :student
      @student_course_year.save
    end
  end
  # Returns the anonymous user.  If the anonymous user does not exist, it is created.  There can be only
  # one anonymous user per database.
  def self.anonymous
    anonymous_user = AnonymousUser.find(:first)
    if anonymous_user.nil?
      anonymous_user = AnonymousUser.create(:name => 'Anonymous', :email => '', :role => 3)
      raise 'Unable to create the anonymous user.' if anonymous_user.new_record?
    end
    anonymous_user
  end

end

  class AnonymousUser < User
  validate :validate_anonymous_uniqueness, :on => :create

  def validate_anonymous_uniqueness
    # There should be only one AnonymousUser in the database
    errors.add :base, 'An anonymous user already exists.' if AnonymousUser.find(:first)
  end

  # Overrides a few properties
  def logged?; false end
  def admin; false end
  def name(*args); I18n.t(:label_user_anonymous) end
  def mail; nil end
  def time_zone; nil end
  def rss_key; nil end

  # Anonymous user can not be destroyed
  def destroy
    false
  end
end
