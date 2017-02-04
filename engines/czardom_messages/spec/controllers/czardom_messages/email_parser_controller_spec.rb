require "rails_helper"

module CzardomMessages
  describe EmailParserController do

    before do
      user = User.new(slug: 'mail-agent', first_name: 'Czardom', last_name: 'Mail Agent', about: "I'm a robot moving emails and messages around for you awesome people!")
      user.save(validate: false)
    end

    after do
      User.find('mail-agent').destroy
    end

    describe "POST 'create" do
      it "has access to EmailParser" do
        post :create, '{}'
        expect(response).to be_ok
      end
    end

  end
end
