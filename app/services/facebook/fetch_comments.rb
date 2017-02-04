module Services
  module Facebook
    class FetchComments

      def self.for_post(post_id)
        graph.get_object("#{post_id}/comments?limit=250")
      rescue Koala::Facebook::ClientError => e
        []
      end

      def self.graph
        Koala::Facebook::API.new(ENV.fetch('FACEBOOK_ACCESS_TOKEN'))
      end

    end
  end
end
