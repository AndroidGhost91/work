module CzardomModels
  class Engine < ::Rails::Engine
    # isolate_namespace CzardomModels

    config.to_prepare do
      Dir.glob(Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer "recommendable" do
      Recommendable.configure do |config|
        # Recommendable's connection to Redis
        config.redis = Redis.new url: ENV["REDIS_URL"]

        # A prefix for all keys Recommendable uses
        config.redis_namespace = :recommendable

        # Whether or not to automatically enqueue users to have their recommendations
        # refreshed after they like/dislike an item
        config.auto_enqueue = true

        # (deprecated) The name of the queue that background jobs will be placed in
        # config.queue_name = :recommendable

        # The number of nearest neighbors (k-NN) to check when updating
        # recommendations for a user. Set to `nil` if you want to check all
        # other users as opposed to a subset of the nearest ones.
        config.nearest_neighbors = nil
      end
    end

    initializer "mailboxer" do
      Mailboxer.setup do |config|

        # Configures if you application uses or not email sending for Notifications and Messages
        config.uses_emails = false

        # Configures the default from for emails sent for Messages and Notifications
        # config.default_from = "no-reply@mailboxer.com"

        # Configures the methods needed by mailboxer
        config.email_method = :email
        config.name_method = :full_name

        # Configures if you use or not a search engine and which one you are using
        # Supported engines: [:solr,:sphinx]
        config.search_enabled = false
        config.search_engine = :solr

        # Configures maximum length of the message subject and body
        config.subject_max_length = 255
        config.body_max_length = 1_000_000
      end
    end
  end
end
