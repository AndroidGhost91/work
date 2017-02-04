class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :tag_user_with_gratis, if: :user_signed_in?
  before_action :move_to_next_onboard_step, :onboard_override, if: :user_signed_in?
  before_action :load_notification, if: :user_signed_in?


  def update_read_notification id
    notification = Notification.where(seen: false, id: id).first
    return unless notification.present?
    notification.update_attributes(seen: true)
  end

  def check_confirmable
    if user_signed_in? && !current_user.confirmed?
      # confirm auto detect on
      current_user.update_column(:state, 'complete')
      sign_out
      redirect_to root_path and return
    end
  end

  protected

  def load_notification
    @notifications = current_user.notifications.limit(5)
  end

  private

  rescue_from CanCan::AccessDenied do |exception|
    render "errors/forbidden", status: 403
  end

  def tag_user_with_gratis
    tag = UserTag.find_or_create_by(name: 'gratis')
    tag.users << current_user unless current_user.user_tag_ids.include?(tag.id)
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def move_to_next_onboard_step
    return if params[:controller] == 'sessions'
    return if params[:user].present? && params[:controller] = 'users'

    case current_user.state
    when 'onboarding_groups'
      unless current_user.groups.count < 5
        # current_user.update_column(:state, 'onboarding_clients')
        current_user.update_column(:state, 'active')
        redirect_to main_app.complete_path and return
      end
    when 'onboarding_clients'
      if current_user.clients.count >= 1
        current_user.update_column(:state, 'active')
        redirect_to main_app.complete_path and return
      end
    end
  end

  def onboard_override
    return if params[:controller] == 'sessions'
    return if params[:user].present? && params[:controller] = 'users'

    case current_user.state
    when 'onboarding_groups'
      redirect_to onboarding_groups_path
    when 'onboarding_clients'
      redirect_to onboarding_clients_path
    end
  end

end
