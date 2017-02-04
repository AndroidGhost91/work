module CzardomAdmin
  class AdminController < ActionController::Base
    before_action :authenticate_user!, :enforce_admin!
    helper TabsHelper
    helper BootstrapHelper

    respond_to :html, :json

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_path, alert: exception.message
    end

    private

    def enforce_admin!
      unless current_user.admin?
        redirect_to main_app.user_path(current_user), alert: 'Not Authorized.'
      end
    end

  end
end
