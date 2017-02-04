class GroupsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    respond_with @groups
  end

  def show
   
    @topics = Forem::Topic
      .where('forum_id = ?', @group.forum_id)
      .by_most_recent_post
      .approved
      .page(params[:page]).per(10)

    respond_with @group
  end

  private

  # Kaminari defaults page_method_name to :page, will_paginate always uses
  # :page
  def pagination_method
    Kaminari.config.page_method_name
  end
  # Kaminari defaults param_name to :page, will_paginate always uses :page
  def pagination_param
    Kaminari.config.param_name
  end
  helper_method :pagination_param

  def forem_admin_or_moderator?(forum)
    false
  end
  helper_method :forem_admin_or_moderator?

end
