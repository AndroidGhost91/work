module CzardomAdmin
  class SpecialOffersController < AdminController
    load_and_authorize_resource

    def index
      @special_offers.order!('created_at desc')
      respond_with @special_offers
    end

    def show
      respond_with @special_offer
    end

    def new
      respond_with @special_offer
    end

    def create
      @special_offer.save
      respond_with @special_offer
    end

    def edit
      respond_with @special_offer
    end

    def update
      @special_offer.update_attributes(special_offer_params)
      respond_with @special_offer
    end

    def destroy
      @special_offer.destroy
      redirect_to special_offers_path
    end

    private

    def special_offer_params
      params.require(:special_offer).permit(:content)
    end

  end
end