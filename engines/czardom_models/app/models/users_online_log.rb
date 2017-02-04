require 'users_online'

class UsersOnlineLog < ActiveRecord::Base
  include UsersOnline

  def self.store_current_users
    log = UsersOnlineLog.new
    user_ids = log.online_user_ids
    create!(user_ids: user_ids, users_count: user_ids.length)
  end
end
