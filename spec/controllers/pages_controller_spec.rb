require "rails_helper"

describe PagesController do
  let(:user) { create(:user, state: 'active') }

  before do
    sign_in user
  end

  describe "GET 'express'" do
    it "sets up a purchase with paypal express" do
      expect(EXPRESS_GATEWAY).to receive(:setup_purchase).with(1800, {
        ip: '0.0.0.0',
        return_url: new_order_url,
        cancel_return_url: complete_url
      }) { double(token: 'express-token') }

      get :express
    end

    it "redirects to express gateway" do
      allow(EXPRESS_GATEWAY).to receive(:setup_purchase) { double(token: 'express-token') }
      get :express
      expect(response).to redirect_to(ActiveMerchant::PaypalBogusGateway::REDIRECT_URL + '?token=express-token')
    end
  end

end
