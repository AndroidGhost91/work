class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [:read], User
      can :manage, User, id: user.id
      can :manage, Group, owner_id: user.id
      can :edit_password

      can [:read, :about, :members, :events, :board], Group
      can [:read, :create, :join, :leave, :follow, :count_by_day], Event
      can [:edit, :update], Event do |event|
        event.user_id == user.id
      end
      can [:read], Tip

      # cannot :flag, Post, author_id: user.id

      if user.admin?
        can :manage, :all
      end
    else
      can :read, :all
      cannot :read, User
      can :read, Job do |job|
        job.job_start_on < Date.today && job.job_end_on > Date.today
      end
    end
  end
end
