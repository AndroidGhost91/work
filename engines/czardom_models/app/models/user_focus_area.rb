class UserFocusArea < ActiveRecord::Base
  belongs_to :user
  belongs_to :focus_area
end
