module EventHelper

  def self.build_reminder_message(event, log_type)
    subject = "Reminder - Your Czardom event is #{log_type}"
    body = "Hello, Czar! <br/>"
    body += "This is a reminder that your event - which you followed of Czardom - is #{log_type} away!<br/>"
    body += "Link to <a href='#{CzardomEvents::Engine.routes.url_helpers.event_path(event)}'>event</a><br/>"
    body += "Warm Regards, <br/>The Czardom Team<br/>"
    body += "To unsubscribe to alerts, click here (<a href='#{Rails.application.routes.url_helpers.user_path(event.user)}#event_notification'>link</a>)"
    {subject: subject, body: body}
  end

end