class Ability
  include CanCan::Ability

  def initialize(user)
    # Admins have ability to assign roles to users
    can :assign_roles, User if @user && @user.admin?
    can :manage, :all if @user && @user.role == "admin"
  #   if user.role? :admin
  #     can :manage, ForumThread
  #   end
  #   if user.role? :moderator
  #     can :manage, Post
  #   end
  #   if user.role? :author
  #     can :manage, Forum
  #   end
  #   if user.role? :banned
  #     can :manage
  end
end