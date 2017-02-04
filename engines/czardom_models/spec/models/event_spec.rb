require "rails_helper"

describe Event do

  context "timeframe" do
    let(:timeframe) { "2015-01-20 01:35am to 2015-01-20 03:45pm" }
    let(:start_at) { DateTime.new(2015, 1, 20, 1, 35) }
    let(:end_at) { DateTime.new(2015, 1, 20, 15, 45) }

    it "gets timeframe from start_at and end_at" do
      event = Event.new(start_at: start_at, end_at: end_at)
      expect(event.timeframe).to eq(timeframe)
    end

    it "assigns start_at" do
      event = Event.new(timeframe: timeframe)
      expect(event.start_at).to eq(start_at)
    end

    it "assigns end_at" do
      event = Event.new(timeframe: timeframe)
      expect(event.end_at).to eq(end_at)
    end
  end

end
