# SHOULD CHECKOUT FOREM::FORUM
# USING NAME OF GROUP FOR CREATE FORUM NAME
class Group < ActiveRecord::Base
  include AlgoliaSearch
  include HasAddress

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope lambda { order(:name) }

  # ASSOCIATIONS
  belongs_to :owner, class_name: 'User'
  has_many :group_users
  has_many :users, through: :group_users

  has_many :posts, as: :postable

  has_many :events, as: :eventable

  belongs_to :forum, class_name: 'Forem::Forum'
  
  has_many :group_sponsors
  has_many :sponsor_logos, through: :group_sponsors

  has_address :address

  validates_presence_of :name
  validates_uniqueness_of :slug

  validates_presence_of :description

  # PROFILE IMAGES
  mount_uploader :image, ImageUploader
  mount_uploader :cover_photo, CoverPhotoUploader

  algoliasearch per_environment: true, disable_indexing: Rails.env.test? do
    attribute :name, :slug, :slug_url
  end

  def full_name
    name
  end

  def add_user(user)
    unless owner_id == user.id || user_ids.include?(user.id)
      users << user
    end
  end

  def remove_user(user)
    group_users.where(user_id: user.id).delete_all
  end

  def self.sticky
    where(sticky: true)
  end

  def create_forum
    category = Forem::Category.find_or_create_by!(name: 'Groups')
    unless forum = Forem::Forum.find_by(name: self.name)
      forum = Forem::Forum.new(name: self.name, description: self.description, category: category)
      forum.valid?
      forum.save(validate: false)
    end
    self.forum_id = forum.id
    self.save(validate: false)
  end

  def slug_url
    Rails.application.routes.url_helpers.group_url(self)
  end
end
