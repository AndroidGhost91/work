module UsersOnline
  def self.included(controller)
    controller.send :helper_method, :online_user_ids if controller.respond_to?(:helper_method)
  end

  def track_user_id(id)
    key = current_key
    $redis.sadd(key, id)
    $redis.expire(key, 6.minutes.to_i)
  end

  def online_user_ids
    $redis.sunion(*keys_in_last_5_minutes)
  end

private

  def key(minute)
    "online_users_minute_#{minute}"
  end

  def current_key
    key(Time.now.strftime('%M'))
  end

  def keys_in_last_5_minutes
    now = Time.now
    times = (0..5).collect { |n| now - n.minutes }
    times.collect { |t| key(t.strftime('%M')) }
  end
end
