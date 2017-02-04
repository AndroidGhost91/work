module Services
  class NewCommentsForFacebookPost < Struct.new(:comments, :existing_ids)

    def self.new_comments(post_id, existing_ids)
  
      comments = Facebook::FetchComments.for_post(post_id)
      new(comments, existing_ids).remove_existing_comments
    end

    def remove_existing_comments
      comments_without_existing_ids
    end

    private

    def comments_without_existing_ids
      @comments_without_existing_ids ||= comments.reject do |c|
        existing_ids.include?(c['id'])
      end
    end

  end
end
