class ConvertGeojson < Struct.new(:addresses, :approximate)
  include ActionView::Helpers::SanitizeHelper

  def to_geojson
    @results_geojson ||= Jbuilder.new do |json|
      json.type 'FeatureCollection'
      json.features addresses do |object|
        user = object.addressable
        next unless user
        user_about = user.about || ''
        longitude = object.longitude
        latitude = object.latitude

        if approximate
          longitude = object.approximate_longitude
          latitude = object.approximate_latitude
        end

        json.type "Feature"
        json.geometry do
          json.type 'Point'
          json.coordinates [longitude, latitude]
        end
        json.properties do
          json.image user.cover_photo_url
          json.avatar user.image_url(:tiny)
          json.name user.full_name
          json.bio strip_tags(user_about).truncate(140)
          json.title "<img class='user-avatar' width='35' src='#{user.image_url(:tiny)}' /> #{user.full_name}"
          json.description "<p>#{user_about.truncate(140)}</p><p class='text-center'><a href='#{user.slug_url}'>View Profile</a></p>"
          json.url user.slug_url
          json.set! 'marker-color', '#5DACD8'
          # json.set! 'marker-symbol', object.addressable_type == 'Event' ? 'star' : 'pitch'
          # json.set! 'marker-size', 'small'
        end
      end
    end.target!
  end

end

