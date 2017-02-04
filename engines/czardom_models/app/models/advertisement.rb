class Advertisement < ActiveRecord::Base
  mount_uploader :image, AdvertisementUploader
end
