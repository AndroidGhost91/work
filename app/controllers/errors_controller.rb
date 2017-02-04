class ErrorsController < ApplicationController
  include Gaffe::Errors

  skip_before_filter :authenticate_user!

  layout 'application'

  def show
    # Here, the `@exception` variable contains the original raised error
    render "errors/#{@rescue_response}", status: @status_code
  end
end
