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
  has_many   :course_years, :through => :user_course_years
  validates_presence_of :user_num,:email
  validates_uniqueness_of :user_num,:email


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
