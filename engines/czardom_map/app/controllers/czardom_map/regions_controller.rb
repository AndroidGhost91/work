module CzardomMap
  class RegionsController < ::ApplicationController
    def index
      @regions = Region.where(object_type: 'User')
      @current_region = params[:id] || 'new-york'
    end

    def users
      @region = Region.where(object_type: 'User').find(params[:id])
      users = @region.results.reject { |a| a.approximate_latitude.blank? || a.approximate_longitude.blank? }
      render json: ConvertGeojson.new(users, true).to_geojson
    end

  end
end
