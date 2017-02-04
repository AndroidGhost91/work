class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    product = Product.find_by!(permalink: cookies[:donate_product_id])
    @order = Services::PaypalOrder.new(request.remote_ip, product.price)
    @order.express_token = params[:token]
  rescue ActiveRecord::RecordNotFound => e
    redirect_to complete_path
  end

  def create
    product = Product.find_by!(permalink: cookies[:donate_product_id])
    @order = Services::PaypalOrder.new(request.remote_ip, product.price)
    @order.express_token = params[:express_token]

    if @order.purchase
      order_details = @order.details
      purchase_details = @order.purchase_response

      amount = purchase_details.params['gross_amount']
      fee_amount = purchase_details.params['fee_amount']

      Payola::Sale.create!({
        owner: current_user,
        state: 'finished',
        product: product,
        stripe_token: 'paypal-order',
        email: order_details.email,
        currency: purchase_details.params['gross_amount_currency_id'],
        amount: (BigDecimal.new(amount) * 100).to_i,
        fee_amount: (BigDecimal.new(fee_amount) * 100).to_i,
        payment_source: 'paypal',
        paypal_payer_id: order_details.payer_id,
        paypal_express_token: order_details.token,
        paypal_transaction_id: purchase_details.params['transaction_id']
      })

      key = "charter-czar-#{current_user.id}"
      $redis.set(key, true)
      $redis.expire(key, 1.month.to_i)

      redirect_to thankyou_path
    else
      error = @order.purchase_response.params['Errors']
      flash.now[:alert] = "PayPal Error (#{error['ErrorCode']}) #{error['LongMessage']}"
      @error = true
      render :new
    end

  rescue ActiveRecord::RecordNotFound => e
    redirect_to complete_path
  end

end
