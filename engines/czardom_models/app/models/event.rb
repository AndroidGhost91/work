class Event < ActiveRecord::Base
  include AlgoliaSearch
  include HasAddress
  include EventHelper
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_messageable

  belongs_to :user
  belongs_to :eventable, polymorphic: true
  has_many :event_users
  has_many :posts, as: :postable
  has_address :address
  belongs_to :topic, class_name: 'Forem::Topic'

  has_many :event_followers
  has_many :user_followings, through: :event_followers, source: :user

  default_scope lambda { order(:priority, :start_at) }

  algoliasearch per_environment: true, disable_indexing: Rails.env.test? do
    attribute :name, :description, :slug, :slug_url
  end

  def can_follow(_user_id)
    event_followers.pluck(:user_id).include? _user_id
  end

  def timeframe
    start_at = self.start_at || Time.now
    end_at = self.end_at || Time.now

    start_date = start_at.strftime('%Y-%m-%d %I:%M%P')
    end_date = end_at.strftime('%Y-%m-%d %I:%M%P')
    "%s to %s" % [start_date, end_date]
  end

  def timeframe=(timeframe)
    @timeframe = timeframe
    date_start, date_end = @timeframe.split(' to ')

    self.start_at = DateTime.parse(date_start)
    self.end_at = DateTime.parse(date_end)
  end

  def self.send_reminder(event, log_type)
    reminder_message = EventHelper.build_reminder_message(event, log_type)
    receiver_log = nil
    if event.user
      # send notification to creator
      unless event.user.email.blank?
        # event.send_message(event.user, reminder_message[:body], reminder_message[:subject])
        receiver_log = event.user
        NotificationMailer.event_notify(event, event.user, log_type).deliver
        ReminderLog.create!(log_type: log_type, object_id: event.id, object_type: 'event', user_id: event.user.id, time_sent: Time.now)
      end
    end

    if event.event_followers.count > 0
      event.user_followings.each do |receiver|
        if receiver.event_notification
          unless receiver.email.blank?
            # event.send_message(receiver, reminder_message[:body], reminder_message[:subject])
            receiver_log = receiver
            NotificationMailer.event_notify(event, receiver, log_type).deliver
            ReminderLog.create!(log_type: log_type, object_id: event.id, object_type: 'event', user_id: receiver.id, time_sent: Time.now)
          end
        end
      end
    end
  rescue => ex
    ReminderLog.create!(log_type: log_type, object_id: event.id, object_type: 'event', user_id: receiver_log.id, time_sent: Time.now, log: ex.message)
    Rails.logger.error "ERROR event_id#{event.id}: #{ex.inspect}"
  end

  def self.reminder
    events = Event.future.where(id: EventFollower.all.pluck(:event_id).uniq)
    reminder_logs = ReminderLog.where("object_type = ? AND object_id IN (?)", "event", events.pluck(:id))
    reminder_has_sent_hour_ids = reminder_logs.where("log_type = ?", "one hour").pluck(:object_id)
    reminder_has_sent_day_ids = reminder_logs.where("log_type = ?", "one day").pluck(:object_id)
    reminder_has_sent_week_ids = reminder_logs.where("log_type = ?", "one week").pluck(:object_id)
    events.each do |event|
      if event.start_at - Time.now <= (1.hour + 10.minutes)
        next if reminder_has_sent_hour_ids.include? event.id
        send_reminder(event, "one hour")
      elsif event.start_at - Time.now <= 1.day
        next if reminder_has_sent_day_ids.include? event.id
        send_reminder(event, "one day")
      elsif event.start_at - Time.now <= 1.week
        next if reminder_has_sent_week_ids.include? event.id
        send_reminder(event, "one week")
      end
    end
  end

  def self.future
    time = Time.now
    where(%q{
      (start_at < ? and end_at > ?)
      or start_at > ?
    }, time, time.end_of_day, time).order(:priority)
  end

  def self.current
    time = Time.now
    where('start_at < ?', time)
      .where('end_at > ?', time).order(:priority)
  end

  def full_name
    title
  end

  def name
    title
  end

  def users_going
    event_users.where(going: true, not_going: false)
  end

  def users_not_going
    event_users.where(going: false, not_going: true)
  end

  def self.add_user(event_id, user_id)
    EventUser.find_or_create_by(event_id: event_id, user_id: user_id)
      .(going: true, not_going: false)
  end

  def self.remove_user(event_id, user_id)
    EventUser.find_or_create_by(event_id: event_id, user_id: user_id)
      .(going: false, not_going: true)
  end

  def slug_url
    CzardomEvents::Engine.routes.url_helpers.event_url(self)
  end

end
