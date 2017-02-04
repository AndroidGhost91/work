class User < ActiveRecord::Base
  include AASM
  include AlgoliaSearch
  include RoleModel
  include HasAddress
  include UserRoles

  EXPORT_ATTRIBUTES = [:id, :first_name, :last_name, :slug_url, :address_city, :address_state, :created_at, :email, :charter_member?, :total_donated]

  recommends :groups

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  before_save :parameterize_slug

  acts_as_messageable
  acts_as_commentable
  has_many :sales, class_name: 'Payola::Sale', as: :owner
  has_one :subscription, class_name: 'Payola::Subscription', as: :owner

  def has_subscription?
    subscription.present?
  end

  aasm column: :state do
    state :onboarding_groups
    state :onboarding_users
    state :onboarding_clients
    state :almost_finish
    state :complete

    state :active, initial: true
    state :banned

    event :activate do
      transitions :to => :active
    end

    event :ban do
      transitions :to => :banned
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, #, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  
  devise :lastseenable

  after_destroy :delete_posts

  # PROFILE IMAGES
  mount_uploader :image, ImageUploader
  mount_uploader :cover_photo, CoverPhotoUploader

  mount_uploader :resume, ResumeUploader

  # ASSOCIATIONS
  has_many :activities, dependent: :destroy
  has_many :posts, as: :postable, dependent: :destroy
  has_many :notifications, lambda { order('created_at desc') }, as: :receiver, dependent: :destroy

  has_many :following, class_name: 'UserFollower', dependent: :destroy
  has_many :following_users, through: :following, source: :following

  has_many :followers, class_name: 'UserFollower', foreign_key: :following_id, dependent: :destroy
  
  has_many :group_users
  has_many :groups, through: :group_users

  has_many :clients, lambda { order(:position) }, class_name: 'UserClient', dependent: :destroy
  accepts_nested_attributes_for :clients, reject_if: proc { |c| c['name'].blank? }, allow_destroy: true

  has_many :event_users
  has_many :events, lambda { where('event_users.going = true and event_users.not_going = false') }, through: :event_users

  has_many :event_followers
  has_many :event_followings, through: :event_followers, source: :event

  has_address :address

  has_many :reputation, class_name: 'UserReputation'

  has_many :user_taggings
  has_many :user_tags, through: :user_taggings

  belongs_to :primary_segment, class_name: 'UserSegment'

  has_many :user_segmentations
  has_many :user_segments, through: :user_segmentations

  has_many :user_focus_areas
  has_many :focus_areas, through: :user_focus_areas

  algoliasearch if: :indexable?, per_environment: true, disable_indexing: Rails.env.test? do
    attribute :full_name, :email, :work, :education, :slug, :slug_url

    attribute :city do
      address.city if address.present?
    end

    attribute :state do
      address.state if address.present?
    end
  end

  # VALIDATIONS
  validates_presence_of :first_name, :last_name, :slug, :about, :work, :education
  validates_uniqueness_of :email, :slug
  validates_uniqueness_of :uid, scope: :provider, if: Proc.new { |u| u.provider.present? }




  def charter_member?
    
    # key = "charter-czar-#{id}"
    # value = $redis.get(key)
    # return value == 'true' unless value.nil?
    has_sale = Payola::Sale.exists?(owner_id: id, state: 'finished') || false;
    # has_sale = payola_sales.exists?(product_type: 'Product', product_id: [5, 6, 7])
    # $redis.set(key, has_sale)
    # if has_sale
    #   $redis.expire(key, 1.month.to_i)
    # else
    #   $redis.expire(key, 2.minutes.to_i)
    # end
    # has_sale
    return has_sale
  end

  # PROFILE FIELDS
  REQUIRED_PROFILE_FIELDS = [:about]

  def complete_profile?
    REQUIRED_PROFILE_FIELDS.all? { |f| read_attribute(f).present? }
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def forem_name
    full_name
  end

  def following_user_ids
    following.pluck(:following_id)
  end
  
  def follow(user)
    following_users << user
  end

  def unfollow(user)
    following_users.delete(user)
  end
  
  def following?(user)
    following_users.include? user
  end
  
  def reputation_total
    reputation.sum(:amount)
  end

  def czemail_address
    @czemail_address ||= "%s@czardom.com" % slug
  end

  #######################################
  # OMNIAUTH AUTHENTICATION
  #######################################
  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
      user.update_info_from_facebook(auth)
    end
  end

  def update_info_from_facebook(auth)
    if auth.info.email.present?
      self.email = auth.info.email
    end

    self.password = Devise.friendly_token[0,20]
    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name
    self.remote_image_url = auth.info.image.gsub('http://','https://')
    self.gender = auth.info.gender

    graph = Koala::Facebook::API.new(auth.credentials.token).get_object('me')
    self.about = graph['bio']
    self.website = graph['website']

    if graph['location'].present?
      location = graph['location']

      if location['name'].present?
        city, state = location['name'].split(',')
        self.build_address({ city: city.try(:strip), state: state.try(:strip), street: '', zip_code: '', country: '' })
      end
    end

    if graph['education'].present?
      school = graph['education'].find { |s| s['type'] == 'College' }
      if school.present?
        self.education = school['school']['name']
      end
    end
    self
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
      end
    end
  end

  def facebook_graph
    @facebook_graph ||= Koala::Facebook::API.new(access_token)
  end

  def facebook_me
    return '' if access_token.blank?
    @facebook_me ||= facebook_graph.get_object('me')
  end

  def slug_url
    Rails.application.routes.url_helpers.user_url(self)
  end

  def total_donated
    sales.sum(:amount) / 100.0
  end

  def address_city
    address.try(:city)
  end

  def address_state
    address.try(:state)
  end

  def online?
    return false unless self[:last_seen].present?
    last_seen > 20.minutes.ago
  end

  def recommendations_count
    Comment.where(commentable_id: id).count
  end

  # manual send confirm mation email
  def send_confirmation_notification?
    false
  end

  def active_for_authentication? 
    return true if self.state != 'complete' 
    super
  end

  def avatar
    {
      small: image_url(:small),
      thumb: image_url(:thumb),
      large: image_url(:large)
    }
  end 

  protected
  # def confirmation_required?
  #   self.state == 'active'
  # end

  private

  def delete_posts
    Post.where(postable: self).destroy_all
    Post.where(author_id: id).destroy_all
  end

  def parameterize_slug
    self.slug = slug.parameterize
  end

  def indexable?
    active? && !email.include?('fb-user-id.com')
  end

end
