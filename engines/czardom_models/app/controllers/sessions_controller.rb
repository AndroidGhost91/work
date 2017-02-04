class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.nil?
      flash.now[:alert] = "Email '#{params[:email]}' could not be found."
      render :new
    elsif user && user.valid_password?(params[:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:alert_html_safe] = "Invalid email address or password. <a href='/users/password/new'>Reset Your Password</a>"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end

