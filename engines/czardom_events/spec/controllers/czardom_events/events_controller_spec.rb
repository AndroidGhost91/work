require "rails_helper"
require 'pry'

module CzardomEvents
  describe EventsController do

    describe "GET 'index'" do
      def new_york_address
        address = create(:address)
        address.update_attributes(latitude: 42.0003251483162, longitude: -74.619140625)
        address
      end

      def miami_address
        address = create(:address)
        address.update_attributes(latitude: 25.8054, longitude: -80.3418)
        address
      end

      def las_vegas_address
        address = create(:address)
        address.update_attributes(latitude: -115.22, longitude: 36.21)
        address
      end

      let!(:new_york_event)  { create(:event, title: 'new-york-event' , start_at: 1.week.from_now, address: new_york_address) }
      let!(:past_event)      { create(:event, title: 'past-event'     , start_at: 1.week.ago     , address: new_york_address, end_at: 1.day.ago) }
      let!(:miami_event)     { create(:event, title: 'miami-event'    , start_at: 1.week.from_now, address: miami_address) }
      let!(:las_vegas_event) { create(:event, title: 'las-vegas-event', start_at: 1.week.from_now, address: las_vegas_address) }

      it "finds upcoming events by region" do
        new_york = create(:region, object_type: 'Event', latitude: 42.0003251483162, longitude: -74.619140625)
        miami = create(:region, object_type: 'Event', latitude: 25.8054, longitude: -80.3418)

        get :index, regions: [new_york.id, miami.id]
        expect(assigns(:events)).to eq([new_york_event, miami_event])
      end
    end

  end
end
