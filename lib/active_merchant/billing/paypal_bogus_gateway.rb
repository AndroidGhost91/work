module ActiveMerchant
  module Billing
    class PaypalBogusGateway < BogusGateway

      REDIRECT_URL = "https://bogus.paypal.com"

      def setup_authorization money, options = {}
        requires!(options, :return_url, :cancel_return_url)
       
        PaypalExpressResponse.new true, SUCCESS_MESSAGE, { Token: AUTHORIZATION }, test: true
      end

      def setup_purchase money, options = {}
        requires!(options, :return_url, :cancel_return_url)
       
        PaypalExpressResponse.new true, SUCCESS_MESSAGE, { Token: AUTHORIZATION }, test: true
      end

      def details_for(token)

        case normalize(token)
        when '1'
          PaypalExpressResponse.new(false, FAILURE_MESSAGE, response_params('payer-failure'), test: true)
        else
          PaypalExpressResponse.new(true, SUCCESS_MESSAGE, response_params('payer-success'), test: true, authorization: AUTHORIZATION)
        end
      end

      def authorize money, options = {}
        requires!(options, :token, :payer_id)
        
        case normalize(options[:token])
        when '1'
          PaypalExpressResponse.new false, FAILURE_MESSAGE, {:authorized_amount => money}, :test => true
        else
          PaypalExpressResponse.new true, SUCCESS_MESSAGE, {:authorized_amount => money}, :test => true, :authorization => AUTHORIZATION
        end
      end

      def purchase money, options = {}
        requires!(options, :token, :payer_id)
        
        case normalize(options[:token])
        when '1'
          PaypalExpressResponse.new false, FAILURE_MESSAGE, {:amount => money}, :test => true
        else
          PaypalExpressResponse.new true, SUCCESS_MESSAGE, {:amount => money}, :test => true, :authorization => AUTHORIZATION
        end
      end
      
      def redirect_url_for token
        REDIRECT_URL + '?token=' + token
      end

      private

      def response_params(payer_id)
        {
          'first_name' => 'buyer-first-name',
          'last_name' => 'buyer-last-name',
          'PayerInfo' => {
            'PayerID' => payer_id
          }
        }
      end

    end
  end
end
