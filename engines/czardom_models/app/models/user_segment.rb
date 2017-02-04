class UserSegment < ActiveRecord::Base
  default_scope lambda { order(:position, :name) }

  has_ancestry

  has_many :primary_users, class_name: 'User', foreign_key: :primary_segment_id
  has_many :secondary_users, class_name: 'User', foreign_key: :secondary_segment_id

  has_many :user_segments, foreign_key: 'ancestry'
  accepts_nested_attributes_for :user_segments, reject_if: lambda { |a| a['name'].blank? }, allow_destroy: true
end
