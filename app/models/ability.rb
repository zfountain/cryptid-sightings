class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all
    elsif user.id
      can :manage, user
      can :manage, Encounter, :user_id => user.id
      can :update, Cryptid
      can :read, Encounter
      can :read, Cryptid
    else
      can :read, Encounter
      can :read, Cryptid
    end
  end
end
