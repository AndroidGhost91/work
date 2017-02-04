class SponsorLogo < ActiveRecord::Base
  has_many :group_sponsors, dependent: :destroy
  has_many :groups, through: :group_sponsors
  
#   extend FriendlyId

#   friendly_id :title, use: :slugged
  
#   validates :title, presence: true

  mount_uploader :image, SponsorLogoUploader

  enum default_status: [ :normal, :default ]
end
