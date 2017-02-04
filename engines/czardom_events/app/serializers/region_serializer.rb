class RegionSerializer < ActiveModel::Serializer
  attributes :id, :title, :latitude, :longitude, :radius
end
