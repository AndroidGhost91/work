class Notification < ActiveRecord::Base
  PARAMS_PERMIT = [
    :sender_id,
    :sender_type, 
    :receiver_id,
    :receiver_type,
    :notifiable_id,
    :notifiable_type, 
    :attached_object_id, # not use it yet
    :attached_object_type, # not use it yet
    :action, # reply, post
    :seen,
    :checked,
    :url, # http://czardom.com.../post/hello-world
    :description
  ]

  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  belongs_to :notifiable, polymorphic: true
  belongs_to :attached_object, polymorphic: true

  scope :unchecked, -> { where(checked: false) }
  scope :unseen, -> { where(seen: false) }

  before_create :generate_description
  before_create :generate_url
  after_create :send_notification

  def self.count_unseen
    unseen.count
  end

  def send_notification
    if should_notify_by_email?
      NotificationMailer.notify_to_user(self).deliver
    end
  end

  def object_type
    action.downcase
  end

  def post
    notifiable
  end

  def generate_description
    self["description"] ||= if object_type == 'reply'
                              # 'reply', Someone comment in post.
                              "#{sender.full_name} replied on #{post.topic.subject} post"
                            else
                              # 'post', someone posted in your group
                              "#{sender.full_name} posted on #{attached_object.full_name} group"
                            end
  end

  def generate_url
    self["url"] ||= if object_type == 'reply'
                      Forem::Engine.routes.url_helpers.forum_topic_post_url(notifiable.forum, notifiable.topic, notifiable)
                    else
                      Forem::Engine.routes.url_helpers.forum_topic_url(notifiable.forum, notifiable)
                    end
  end

  private

  def should_notify_by_email?
    return false unless receiver
    receiver.notification_by_email
  end

end
