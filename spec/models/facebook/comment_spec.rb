require "spec_helper"
require "active_model"
require "./app/models/facebook/comment"

module Facebook
  describe Comment do

    let(:comment) do
      Comment.new({
        'id' => 'comment-id',
        'message' => 'comment-message',
        'created_time' => '2015-01-20T13:45:30+0000',
        'from' => {
          'id' => 'from-id',
          'name' => 'from-name'
        }
      })
    end

    context "id" do
      it "gets id" do
        expect(comment.id).to eq('comment-id')
      end
    end

    context "message" do
      it "gets message" do
        expect(comment.message).to eq('comment-message')
      end
    end

    context "created_at" do
      it "parsed created_time" do
        expect(comment.created_at).to eq(DateTime.new(2015, 1, 20, 13, 45, 30))
      end
    end

    context "from_name" do
      it "gets from name" do
        expect(comment.from_name).to eq('from-name')
      end
    end

    context "from_id" do
      it "gets from id" do
        expect(comment.from_id).to eq('from-id')
      end
    end

  end
end
