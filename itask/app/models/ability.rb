class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.blank?
      # not logged in
      cannot :manage, :all
      basic_read_only

    elsif user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :teacher
      can :manage, CourseYear, :course => {:user => user }
      can :manage, Assignment, :course_year => {:course => {:user => user }}
      can :manage, User ,:id => user.id 
      can :manage, UserCourseYear,:course_year => {:course=>{:user => user}}
      can :destroy, StudentCourseAssignment,:assignment=>{:course_year => { :course=>{:user=>user} }}
      basic_read_only
    elsif user.has_role? :TA
      can :manage, CourseYear, :assistants => {:user => user} 
      can :manage, Assignment, :user => user 
      can :manage, User ,:id => user.id 
      can :manage, UserCourseYear,:course_year => {:assistants => {:user => user}}
      can :create, StudentCourseAssignment 

      can :manage, StudentCourseAssignment,:user => user

      basic_read_only
    elsif user.has_role? :student
      can :manage, User ,:id => user.id  
      can :manage, StudentCourseAssignment,:user => user
      can :create, StudentCourseAssignment 
      cannot :grade, StudentCourseAssignment
      basic_read_only
    else
      basic_read_only
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
  protected
    def basic_read_only
      can :read,CourseYear
      can :apply,CourseYear
      can :read,User
      can :read,Assignment
      can :unfinished,Assignment
      can :read,Event

    end
end
# class Course
#     belongs_to :course_year
#     end
# class CourseYear
#         has_many :courses
#         scope :owned, includes(:courses).where(:user_id => {:id => nil})
# end
