Forem::Post.class_eval do
  include AlgoliaSearch

  delegate :subject, :views_count, to: :topic, prefix: :topic
  delegate :full_name, :slug_url, :image_url, to: :forem_user, prefix: :user

  algoliasearch if: :approved?, per_environment: true, disable_indexing: Rails.env.test?, sanitize: true do

    attributesToIndex %w[text topic_subject]
    attributesForFaceting %w[user.id]
    customRanking %w[desc(topic_views_count)]

    attribute :topic_subject, :topic_id, :topic_views_count
    attribute :text
    attribute :created_at do
      created_at.to_i
    end
    attribute :user do
      {
        id: user_id,
        full_name: user_full_name,
        slug_url: user_slug_url,
        avatar_url: user_image_url(:small)
      }
    end

    attribute :slug_url do
      Forem::Engine.routes.url_helpers.forum_topic_path(topic, forum_id: forum.slug) + "#post-#{id}"
    end

  end
end
