class Ability
  include CanCan::Ability

  def initialize(user)
    can :new, Project
  end
end
