module CzardomAdmin
  class RegionsController < AdminController
    load_and_authorize_resource

    def index
      respond_with @regions
    end

    def show
      respond_with @region
    end

    def create
      @region.save
      respond_with @region
    end

    def edit
      respond_with @region
    end

    def update
      @region.update_attributes(region_params)
      respond_with @region
    end

    def destroy
      @region.destroy
      redirect_to regions_path
    end

    private

    def region_params
      params.require(:region).permit!
    end
  end
end
