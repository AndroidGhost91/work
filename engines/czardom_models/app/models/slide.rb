class Slide < ActiveRecord::Base
  mount_uploader :image, SlideImageUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image
  
  has_one :root_article, :dependent => :destroy
  
  accepts_nested_attributes_for :root_article, reject_if: proc { |attributes| attributes['title'].blank? }
  
  enum use_url: [ :use_url, :use_article ]
 
  def crop_image
    image.recreate_versions! if crop_x.present?
  end
end
