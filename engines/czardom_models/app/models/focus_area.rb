class FocusArea < ActiveRecord::Base
  default_scope { order(:position, :name) }

  has_many :user_focus_areas
  has_many :users, through: :user_focus_areas
end
