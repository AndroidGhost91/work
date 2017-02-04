require "rails_helper"

module Services
  describe CreateUserFromFacebookComment do

    context "create_user" do
      let(:comment) { ::Facebook::Comment.new(from: {'name' => 'Bob Jones Wiley', 'id' => 'from-id'}) }
      let(:user) { CreateUserFromFacebookComment.new(comment.from).create_user }

      it "creates a user" do
        expect(user.persisted?).to be_truthy
      end

      it "assigns a first name" do
        expect(user.first_name).to eq('Bob Jones')
      end

      it "assigns a last name" do
        expect(user.last_name).to eq('Wiley')
      end

      it "assigns an email" do
        expect(user.email).to eq('from-id@fb-user-id.com')
      end

      it "assigns a password" do
        expect(user.encrypted_password).to_not be_blank
      end

      it "assigns a uid" do
        expect(user.uid).to eq('from-id')
      end

      it "assigns the provider as facebook" do
        expect(user.provider).to eq('facebook')
      end
    end

  end
end
