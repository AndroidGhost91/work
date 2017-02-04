module Dto
  module Board
    class User < Base

      def to_hash
        {
          id: object.try(:id),
          deleted: object.is_a?(Forem::NilUser),
          first_name: object.try(:first_name),
          last_name: object.try(:last_name),
          charter_member: object.try(:charter_member?) || false,
          profile_url: user_link,
          avatar: {
            small: object.image_url(:small),
            thumb: object.image_url(:thumb),
            large: object.image_url(:large)
          }
        }
      end

      private

      def user_link
        if object.is_a?(Forem::NilUser)
          '#'
        else
          user_url(object)
        end
      end

    end
  end
end
