class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :read, Article
    if user
      can :create, Project
      can [:create,:update], Article
      can :create, Relation
    end
  end
end
