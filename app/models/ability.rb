class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? "admin"
      can :manage, :all
    else
      can :manage, Post, user_id: user.id
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
