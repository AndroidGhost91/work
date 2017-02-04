class UserClient < ActiveRecord::Base
  include AlgoliaSearch

  mount_uploader :image, ImageUploader

  belongs_to :user
  delegate :full_name, :slug, :slug_url, to: :user, prefix: :user

  algoliasearch per_environment: true, disable_indexing: Rails.env.test? do
    attribute :name, :user_id, :user_full_name, :user_slug

    attribute :slug_url do
      user_slug_url
    end
  end
end
