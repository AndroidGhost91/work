class Media < ActiveRecord::Base
  mount_uploader :media, MediaUploader
end
