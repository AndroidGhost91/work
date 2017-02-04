module CzardomEvents
  module EventsHelper

    def going_to_event(event)
      event.users_going.pluck(:user_id).include?(current_user.id)
    end

    def not_going_to_event(event)
      event.users_not_going.pluck(:user_id).include?(current_user.id)
    end

  end
end
