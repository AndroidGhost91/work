module CzardomAdmin
  class AdminAbility
    include CanCan::Ability

    attr_reader :user

    def read_object(object)
      if user.has_role? plural_name(object).to_sym
        can :read, object
      end
    end

    def edit_object(object)
      if user.has_role? "edit_#{singular_name(object)}".to_sym
        can :edit_actions, object
      end
    end

    def read_and_edit_actions(object)
      read_object(object)
      edit_object(object)
    end

    def initialize(user)
      return unless user.present?
      @user = user

      can :impersonate, User
      
      alias_action :create, :read, :update, to: :edit_actions

      #
      # USERS
      read_and_edit_actions(User)

      if user.has_role? :user_account_status
        can :change_account_status, User
      end

      #
      # GROUPS
      read_and_edit_actions(Group)
     
      if user.has_role? :edit_group
        can :create_board, Group
      end

      if user.has_role? :delete_group
        can :destroy, Group
      end

      #
      # PRODUCTS, REGIONS, MESSAGES
      read_and_edit_actions(Product)
      read_object(SubscriptionPlan)
      can :create, SubscriptionPlan if user.has_role? :create_subscription_plan

      if user.has_role? :messages
        can :read, Mailboxer::Conversation
      end

      read_and_edit_actions(Slide)
      can :destroy, Slide if user.has_role? :delete_slide

      read_and_edit_actions(Region)

      if user.has_role? :delete_region
        can :destroy, Region
      end

      #
      # SALES
      if user.has_role? :sales
        can :index, Payola::Sale
      end

      if user.has_role? :individual_sale
        can :show, Payola::Sale
      end

      # TIPS
      read_and_edit_actions(Tip)
      if user.has_role? :delete_tip
        can :destroy, Tip
      end

      # SPECIAL OFFER
      read_and_edit_actions(SpecialOffer)
      if user.has_role? :delete_special_offer
        can :destroy, SpecialOffer
      end

      if user.admin?
        can :manage, SpecialOffer
        can :manage, Tip
        can :manage, Slide
        can :manage, Event
      end
    end
    
    private

    def singular_name(object)
      object.name.underscore
    end

    def plural_name(object)
      singular_name(object).pluralize
    end
  end
end
