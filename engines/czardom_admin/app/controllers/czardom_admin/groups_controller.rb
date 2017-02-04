module CzardomAdmin
  class GroupsController < AdminController
    load_and_authorize_resource

    def index
      respond_with @groups
    end

    def show
      respond_with @group
    end

    def new
      respond_with @group
    end

    def create
      @group.save
      respond_with @group
    end

    def edit
      respond_with @group
    end

    def update
      @group.update_attributes(group_params)
      respond_with @group
    end

    def destroy
      @group.destroy
      respond_with @group
    end

    def create_board
      @group.create_forum
      respond_with @group
    end

    private

    def group_params
      params.require(:group).permit!
    end

  end
end
