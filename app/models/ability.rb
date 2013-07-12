class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, Article
    can :read, Relation
    if user
      can :create, Project
      can [:create,:update,:destroy], Article
      can [:create,:destroy], Relation
      can [:create,:update], History
    end
  end
end
