module Facebook
  class Comment
    include ActiveModel::Model
    attr_accessor :id, :from, :message, :created_time
    attr_accessor :can_remove, :like_count, :user_likes, :message_tags

    def created_at
      DateTime.parse(created_time)
    end

    def from_name
      from['name']
    end

    def from_id
      from['id']
    end
  end
end
