class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin? # Admins can do everything
      can :manage, :all
    elsif user # Logged in user
      can :switch, Organization
      can :manage, :profile

      bartender(user) if user.bartender?
      planner(user)   if user.planner?
      manager(user)   if user.manager?
    end

    # Everyone can view events
    can :read, Event
  end

  def bartender(user)
    can :create, Enrollment
  end

  def planner(user)
    can :manage, Enrollment, event: { organizer: user.current_organization }
    can :manage, Event, organizer: user.current_organization
  end

  def manager(user)
    can :manage, Membership, organization: user.current_organization
  end
end
