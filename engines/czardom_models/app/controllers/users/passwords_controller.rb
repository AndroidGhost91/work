class Users::PasswordsController < Devise::PasswordsController

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    error_fields = resource.errors.keys

    if error_fields.include?(:password) || error_fields.include?(:password_confirmation)
      respond_with resource
    else
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_flashing_format?
      sign_in(resource_name, resource)
      redirect_to user_path(resource)
    end
  end
end
