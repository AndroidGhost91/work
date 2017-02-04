class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if user_signed_in?
      @user = current_user
      attrs = {
        uid: auth.uid,
        provider: 'facebook',
        access_token: auth.credentials.token,
        access_token_expires_at: Time.at(auth.credentials.expires_at)
      }

      if @user.update_attributes(attrs)
        flash[:notice] = 'Connected to facebook.'
        redirect_to @user
      else
        flash.now[:alert] = 'Failed to connect to facebook'
        render 'users/edit'
      end

      return
    end

    @user = User.from_omniauth(auth)

    if @user.persisted? || (@user.email.present? && @user.email.include?('fb-user-id.com'))
      # ignore confirmation for facebook user
      @user.skip_confirmation!
      if @user.email.include?('fb-user-id.com')
        @user.update_info_from_facebook(auth)
        @user.save(validate: false)
      end
      # puts auth.credentials
      puts @user
      # unless auth.credentials.expires_at.nil? then
      unless auth.credentials.expires_at == nil then
          @user.update_attributes(
          access_token: auth.credentials.token,
          access_token_expires_at: Time.at(auth.credentials.expires_at))    
      end
 
      sign_in @user
      redirect_to main_app.root_path
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_path
    end
  rescue ActiveRecord::StatementInvalid => e
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    redirect_to new_user_path
  end

  def auth
    request.env["omniauth.auth"]
  end

  private

  def after_omniauth_failure_path_for(scope)
    main_app.root_path
  end
end
