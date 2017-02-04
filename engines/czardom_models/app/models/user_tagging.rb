class UserTagging < ActiveRecord::Base
  belongs_to :user_tag
  belongs_to :user
end
