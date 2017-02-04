module ForemHelper

  def forum_group(forum_id = nil)
    forum_id ||= @forum
    @group ||= Group.find_by_forum_id(forum_id)
  end

  def forum_group?(forum_id = nil)
    (forum_id || @forum.present?) && forum_group(forum_id).present?
  end

  def back_button
    link = link_to("Back", "javascript:history.back();", class: "btn btn150 btn-default pull-right btn-back")
    '<div class="form-group clearfix">'+link+'</div>'
  end

end
