require "spec_helper"
require "./app/services/new_comments_for_facebook_post"
require "./app/services/facebook/fetch_comments"

module Services
  describe NewCommentsForFacebookPost do

    context "remove_existing_comments" do
      let(:existing_ids) { ['old-comment-id'] }

      let(:old_comment) do
        {'id' => 'old-comment-id', 'message' => 'old-comment'}
      end

      let(:new_comment) do
        {'id' => 'new-comment-id', 'message' => 'new-comment'}
      end

      it "removes comments with existing ids" do
        allow(Facebook::FetchComments).to receive(:for_post)
          .with('post-id') { [old_comment, new_comment] }

        new_comments = NewCommentsForFacebookPost.new_comments('post-id', existing_ids)
        expect(new_comments).to eq([new_comment])
      end
    end

  end
end
