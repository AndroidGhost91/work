class SpecialOffersController < ApplicationController
  def index
    @special_offers = SpecialOffer.all
  end
end
