module CzardomAdmin
  class TipsController < AdminController
    load_and_authorize_resource

    def index
      @tips.order!('created_at desc')
      respond_with @tips
    end

    def show
      respond_with @tip
    end

    def new
      respond_with @tip
    end

    def create
      @tip.save
      respond_with @tip
    end

    def edit
      respond_with @tip
    end

    def update
      @tip.update_attributes(tip_params)
      respond_with @tip
    end

    def destroy
      @tip.destroy
      redirect_to tips_path
    end

    private

    def tip_params
      params.require(:tip).permit(:content)
    end

  end
end