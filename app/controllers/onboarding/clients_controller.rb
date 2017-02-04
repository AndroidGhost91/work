class Onboarding::ClientsController < OnboardingController
  skip_before_action :onboard_override

  respond_to :html, :json

  def index
    @clients = current_user.clients
    @clients.build
    respond_with @clients
  end
end
