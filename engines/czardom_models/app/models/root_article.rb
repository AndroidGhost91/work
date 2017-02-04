class RootArticle < ActiveRecord::Base
  belongs_to :slide
  extend FriendlyId

  friendly_id :title, use: :slugged
  
  validates :title, presence: true
end
