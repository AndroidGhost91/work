class NotificationMailer < ApplicationMailer
    
    def notify_to_user(notification)
      # only pass id to make it easier to send emails using resque
      # @sender = notification.sender
      @receiver = notification.receiver
      # @notifiable = notification.notifiable
      # @attached_object = notification.attached_object
      @description = notification.description
      @url = notification.url
      # @action = notification.action

     # mail(:to => @receiver.email, :subject => @description )
    end

    def event_notify(event, receiver, log_type)
      @log_type = log_type
      @event = event
      @receiver = receiver
      @user  = event.user
      subject = "Reminder - Your Czardom event is #{log_type}"
      mail(:to => @receiver.email, :subject => subject )
    end
end