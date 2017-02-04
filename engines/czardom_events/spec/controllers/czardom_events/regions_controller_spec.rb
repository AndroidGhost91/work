require "rails_helper"

module CzardomEvents
  describe RegionsController do

    describe "GET 'index'" do
      before do
        [
          {
            title: 'region-1',
            latitude: 100,
            longitude: 100,
            radius: 100,
            object_type: 'Event'
          },
          {
            title: 'region-2',
            latitude: 200,
            longitude: 200,
            radius: 200,
            object_type: 'User'
          },
          {
            title: 'region-3',
            latitude: 300,
            longitude: 300,
            radius: 300,
            object_type: 'Event'
          }
        ].each do |region|
          Region.create!(region)
        end
      end

      it "gets regions json" do
        get :index
        expect(JSON.parse(response.body)).to eq({ 'regions' => [
          {
            'id' => Region.find_by(title: 'region-1').id,
            'title' => 'region-1',
            'latitude' => 100,
            'longitude' => 100,
            'radius' => 100
          },
          {
            'id' => Region.find_by(title: 'region-3').id,
            'title' => 'region-3',
            'latitude' => 300,
            'longitude' => 300,
            'radius' => 300
          }
        ]})
      end
    end

  end
end
