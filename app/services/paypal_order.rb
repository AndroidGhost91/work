module Services
  class PaypalOrder < Struct.new(:ip_address, :price_in_cents)
    attr_accessor :express_token, :express_payer_id
    attr_accessor :purchase_response, :details, :params

    def amount
      price_in_cents / 100.0
    end

    def purchase
      @purchase_response = process_purchase
      @purchase_response.success?
    end

    def express_token=(token)
      @express_token = token
      unless token.blank?
        @details = EXPRESS_GATEWAY.details_for(token)
        @params = details.params
        @express_payer_id = details.payer_id
      end
    end

    private

    def process_purchase
      EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
    end

    def express_purchase_options
      {
        :ip => ip_address,
        :token => express_token,
        :payer_id => express_payer_id
      }
    end

  end
end
