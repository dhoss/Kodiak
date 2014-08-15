class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? "admin"
      can :manage, :all
    elsif user.role? "poster"
      can :manage, Post, user_id: user.id
      can :create, Post, user_id: user.id
      can :manage, Photo, user_id: user.id
      can :create, Photo, user_id: user.id
      can :read, :all
    else
      can :read, :all
    end
  end
end
