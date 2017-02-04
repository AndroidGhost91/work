module CzardomEvents
  class RegionsController < EventsApplicationController

    def index
      @regions = Region.where(object_type: 'Event')
      render json: @regions
    end

  end
end
