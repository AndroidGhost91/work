class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:earlybird, :complete, :thankyou, :express]

  def show
    @page = Page.find(params[:id])
  end

  def home
  end

  def earlybird
    @product = Product.find_by(permalink: 'earlybird')
  end

  def complete
    # send email confirm
    unless current_user.confirmed?
      current_user.send_confirmation_instructions
      flash[:notice] = "Email confirmation sent to your email address. Please confirm"
      current_user.update_column(:state, 'almost_finish') if current_user.state != "complete"
    end
    @products = {
      'chai' => Product.find_by(permalink: 'earlybird'),
      'double-chai' => Product.find_by!(permalink: 'double-chai'),
      'triple-chai' => Product.find_by!(permalink: 'triple-chai')
    }
  end

  def thankyou
  end

  def express
    product = Product.find_by!(permalink: params[:product])
    cookies[:donate_product_id] = product.permalink

    response = EXPRESS_GATEWAY.setup_purchase(product.price,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => complete_url,
      brand_name: 'CZARDOM',
      logo_image: 'http://www.czardom.com/pp-header-white.png'
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  rescue ActiveRecord::RecordNotFound => e
    render :complete
  end

  def states_for_country
    country = params.fetch(:code, 'US')
    render json: Country.new(country).try(:subdivisions)
  end

end
