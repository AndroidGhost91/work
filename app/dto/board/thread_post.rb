require "rinku"
module Dto
  module Board
    class ThreadPost < Base
      include Forem::FormattingHelper

      def new_object_hash(object)
        {
          id: object.id,
          created_at: object.created_at,
          user: Dto::Board::User.new(object.user),
          text: Rinku.auto_link(object.text),
          media: object.media,
          reply_to: nil,
          reply_to_id: nil,
          reply_url: object.reply_url,
          replies: []
        }
      end

      def to_hash
        hash = new_object_hash(object)

        if object.replies.count > 0
          object.replies.sort_by {|created_at| created_at}.each do |post|
            post_hash = new_object_hash(post)
            
            post.replies.sort_by {|created_at| created_at}.each do |reply|
              reply_post_hash = new_object_hash(reply)
              if reply.reply_to.present?
                reply_post_hash[:reply_to] = new_object_hash(reply.reply_to)
                reply_post_hash[:reply_to_id] = reply.reply_to_id
              end

              post_hash[:replies] << reply_post_hash 
            end
          
            if post.reply_to.present?
              post_hash[:reply_to] = new_object_hash(post.reply_to)
              post_hash[:reply_to_id] = post.reply_to_id
            end

            hash[:replies] << post_hash
          end
        end
        if object.reply_to.present?
          hash[:reply_to] = new_object_hash(object.reply_to)
          hash[:reply_to_id] = object.reply_to_id
        end

        hash
      end

    end
  end
end
