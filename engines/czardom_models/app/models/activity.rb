class Activity < ActiveRecord::Base
  belongs_to :user
  delegate :full_name, to: :user, prefix: :user

  belongs_to :trackable, polymorphic: true
end
