class Region < ActiveRecord::Base
  default_scope lambda { order(:title) }

  TYPES = %w(User Group Event)

  validates_presence_of :title, :object_type, :latitude, :longitude, :radius
  validates_inclusion_of :object_type, in: TYPES

  def results
    @results if @results.present?
    addresses = Address.where(addressable_type: object_type).includes(:addressable)
    @results = addresses.near([latitude, longitude], radius, latitude: :latitude, longitude: :longitude)
  end

  def results_geojson
    ConvertGeojson.new(results).to_geojson
  end
end
