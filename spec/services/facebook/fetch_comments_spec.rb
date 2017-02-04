require "spec_helper"
require "koala"
require "./app/services/facebook/fetch_comments"

module Services
  module Facebook
    describe FetchComments do

      context "for_post" do
        let(:graph) { double }

        before do
          allow(FetchComments).to receive(:graph) { graph }
        end

        it "finds comments for post" do
          expect(graph).to receive(:get_object).with('post-id/comments?limit=250')
          FetchComments.for_post('post-id')
        end

        it "returns empty array when object can't be found" do
          allow(graph).to receive(:get_object).with('invalid-post/comments?limit=250') do
            raise Koala::Facebook::ClientError.new(400, '')
          end

          expect(FetchComments.for_post('invalid-post')).to eq([])
        end
      end

    end
  end
end
