module CzardomAdmin
  class SubscriptionPlansController < AdminController
    load_and_authorize_resource

    def index
      respond_with @subscription_plans
    end

    def new
      @subscription_plan.interval = 'month'
      @subscription_plan.interval_count = 1
      respond_with @subscription_plan
    end

    def create
      if @subscription_plan.save
        redirect_to subscription_plans_path
      else
        render :new
      end
    end

    private

    def create_params
      params.require(:subscription_plan).permit(
        :name, :amount, :currency, :interval, :interval_count, :features,
        :trial_period_days
      )
    end

    def update_params
      params.require(:subscription_plan).permit(:name, :features)
    end
  end
end
