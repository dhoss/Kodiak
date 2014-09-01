class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? "admin"
      can :manage, :all
    end

    can :manage, User do |u|
      user.try(:user) == user
    end

    can :update, User do |u|
      user.try(:user) == user
    end

    can :delete, User do |u|
      user.try(:user) == u
    end

    can :manage, Gallery do |u|
      user.try(:user) == user
    end

    can :update, User do |u|
      user.try(:user) == user
    end

    can :delete, User do |u|
      user.try(:user) == u
    end

    if user.role? "poster"
      can :manage, Post do |post|
        post.try(:user) == user
      end
      can :read, :all
      can :create, Post
      can :update, Post do |post|
        post.try(:user) == user 
      end
      can :delete, Post do |post|
        post.try(:user) == user
      end
    end
  end
end
