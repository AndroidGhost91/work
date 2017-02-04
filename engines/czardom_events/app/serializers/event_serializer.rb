class EventSerializer < ActiveModel::Serializer
  include CzardomEvents::Engine.routes.url_helpers

  attributes :id, :title, :description, :description_truncated, :start_at, :end_at, :url, :users_going, :status

  def description_truncated
    object.description.truncate(170, separator: ' ')
  end

  def url
    event_url(object.slug)
  end

  def users_going
    object.users_going.count
  end

  def status
    if object.users_going.pluck(:user_id).include?(scope.id)
      'Going'
    elsif object.users_not_going.pluck(:user_id).include?(scope.id)
      'Not Going'
    else
      'RSVP'
    end
  end
end
