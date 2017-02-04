# class NotificationPresenter < SimpleDelegator
#   attr_reader :notification

#   def initialize(notification, view)
#     super(view)
#     @notification = notification
#   end

#   def render_notification
#     return if notification.notifiable.blank?
#     obj = notification.notifiable
#     method = "#{obj.class.name.demodulize.underscore}_path"
#     link_to (sender + ' ' + action + ' ' + time), main_app.send(method, obj.to_param)
#   end

#   def sender
#     content_tag(:strong, notification.sender.full_name)
#   end

#   def action
#     t("notifications.#{notification.action}")
#   end

#   def time
#     content_tag(:strong, time_ago_in_words(notification.created_at) + ' ago')
#   end
# end
