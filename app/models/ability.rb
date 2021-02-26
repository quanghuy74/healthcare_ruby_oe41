
class Ability
  include CanCan::Ability

  def initialize(account)
    cannot :manage, Admin::OrdersController
    cannot :manage, Admin::StatisticsController
    cannot :manage, Staff::WorkHistoriesController
    cannot :manage, Staff::StaffsController
    can :read, Account
    can :read, Review
    can :read, Service
    can :read, Major

    return if account.blank?

    if account.admin?
      can :manage, :all
    elsif account.staff?
      can :manage, Staff::WorkHistoriesController
      can :manage, Staff::StaffsController
      can [:update, :read], Order, OrderDetail
    else
      can :update, Account, id: account.id
      can :manage, Review, rated_review: {reviewer_id: account.id}
      can :manage, License, account_id: account.id
      cannot :destroy, License
      can :manage, Order, account_id: account.id
      cannot :destroy, Order, account_id: account.id
    end
  end
end
