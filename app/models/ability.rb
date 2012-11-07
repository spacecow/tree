class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, Article
    can :read, Relation
    if user
      can :create, Project
      can [:create,:update], Article
      can :create, Relation
      can :create, History
    end
  end
end
