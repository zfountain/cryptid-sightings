class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all
    else
      can :manage, user
      can :manage, Encounter, :user_id => user.id
      can :manage, Cryptid
      can :read, :all
    end
  end
end
