class UserSegmentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_segment
end
